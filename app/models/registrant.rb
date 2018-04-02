require 'csv'

class Registrant < ActiveRecord::Base
  belongs_to :pass
  belongs_to :season

  validate :within_role
  validates :email, presence: true, unless: :couple_pass?
  before_create :add_season

  scope :current, -> { where(season_id: Season.current_id ) }
  default_scope { current }

  def self.parse(file)
    result = []
    mapping = code
    CSV.foreach(file, headers: true, encoding: 'UTF-8') do |row|
      if (r = Registrant.find_by_email(row[mapping[:email]])).present?
        saved_payment = false
        if !r.paid && row[mapping[:paid]]
          r.paid = true
          r.save
          saved_payment = true
        end
        result << {name: row[mapping[:name]], registrant: r, existing: true, registered_payment: saved_payment}
      else
        begin
          reg = Registrant.new name: row[mapping[:name]],
                            email: row[mapping[:email]],
                            pass: Pass.find_by_name(row[mapping[:pass]]),
                            level: row[mapping[:level]],
                            role: find_role(row[mapping[:role]]),
                            paid: row[mapping[:paid]].present?
          if reg.save
            if reg.pass.blank?
              result << {name: row[mapping[:name]], registrant: reg, warning: :empty_pass}
            else
              result << {name: row[mapping[:name]], registrant: reg}
            end
          else
            result << {name: row[mapping[:name]], registrant: reg, error: true}
          end
        rescue
          result << {name: row[mapping[:name]], registrant: reg, error: true}
        end
      end
    end
    result
  end

  def self.code
    if Season.current.upload_fields.empty?
      {
        name: "Nombre y Apellido",
        email: "Correo electrónico",
        pass: "Pase",
        partner: "Nombre de tu pareja",
        level: "Cuál es tu nivel",
        role: "Elegí tu rol primario para las clases",
        sat_class: "Clase optativa sábado",
        sun_class: "Clase optativa domingo",
        paid: "Cuanto",
        activities: "¿A que actividades querés venir?"
      }
    else
      @code ||= Season.current.upload_fields_hash.with_indifferent_access
    end
  end

  def self.roles
    ['leader', 'follower']
  end

  def self.levels
    Season.current.levels || ['beginner', 'intermediate', 'advanced']
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

  # Deprecated
  def self.find_level(level)
    return nil if level.nil?
    if level.match(/.*spoon.*/i)
      'intermediate'
    elsif level.match(/.*first.*/i)
      'beginner'
    end
  end

  def self.find_role(role)
    return nil if role.nil?
    if role.match(/.*lead.*/i)
      'leader'
    elsif role.match(/.*follow.*/i)
      'follower'
    end
  end

  def couple_pass?
    !pass.nil? && pass.name == "Pase pareja"
  end

  def within_role
    if role.present? && !Registrant.roles.include?(role)
      errors.add(:level, "is invalid")
    end
  end

  def add_season
    self.season_id = Season.current_id unless self.season_id
  end


end
