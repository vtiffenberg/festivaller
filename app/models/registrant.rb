require 'csv'

class Registrant < ActiveRecord::Base
  belongs_to :pass
  belongs_to :season

  validate :within_role
  validate :within_level
  validates_presence_of :pass_id
  validates :email, presence: true, unless: :couple_pass?
  before_create :add_season

  scope :current, -> { where(season_id: Season.current_id ) }
  default_scope { current }

  def self.parse(file)
    result = []
    CSV.foreach(file, headers: true, encoding: 'UTF-8') do |row|
      if (r = Registrant.find_by_email(row[code[:email]])).present?
        saved_payment = false
        if !r.paid && row[code[:paid]]
          r.paid = true
          r.save
          saved_payment = true
        end
        result << {name: row[code[:name]], registrant: r, existing: true, registered_payment: saved_payment}
      else
        begin
          reg = Registrant.new name: row[code[:name]],
                            email: row[code[:email]],
                            pass: Pass.find_by_name(row[code[:pass]]),
                            level: find_level(row[code[:level]]),
                            role: row[code[:role]].try(:downcase),
                            paid: row[code[:paid]].present?
          if row[code[:partner]].present?
            reg.partner = row[code[:partner]]
            partner = Registrant.new name: row[code[:partner]],
                          pass: Pass.find_by_name(row[code[:pass]]),
                          level: find_level(row[code[:level]]),
                          role: opposite_role(row[code[:role]].try(:downcase))
          end
          if reg.save
            result << {name: row[code[:name]], registrant: reg}
            if partner
              partner.save
              result << {name: row[code[:partner]], registrant: partner}
            end
          else
            result << {name: row[code[:name]], registrant: reg, error: true}
          end
        rescue
          result << {name: row[code[:name]], registrant: reg, error: true}
        end
      end
    end
    result
  end

  def self.code
    {
      name: "Nombre y apellido",
      email: "Correo electrónico",
      pass: "Pase",
      partner: "Nombre de tu pareja",
      level: "Cuál es tu nivel",
      role: "Elegí tu rol",
      sat_class: "Clase optativa sábado",
      sun_class: "Clase optativa domingo",
      paid: "Pago"
    }
  end

  def self.roles
    ['leader', 'follower']
  end

  def self.levels
    ['beginner', 'intermediate', 'advanced']
  end

  private

  def self.opposite_role(role)
    if roles[0] == role
      roles[1]
    elsif roles[1] == role
      roles[0]
    else
      nil
    end
  end

  def self.find_level(level)
    return nil if level.nil?
    if level.match(/.*spoon.*/)
      'intermediate'
    elsif level.match(/.*first.*/)
      'beginner'
    end
  end

  def couple_pass?
    pass.name == "Pase pareja"
  end

  def within_role
    if role.present? && !Registrant.roles.include?(role)
      errors.add(:level, "is invalid")
    end
  end

  def within_level
    if level.present? && !Registrant.levels.include?(level)
      errors.add(:level, "is invalid")
    end
  end

  def add_season
    self.season_id = Season.current_id unless self.season_id
  end


end
