require 'csv'

class Registrant < ActiveRecord::Base
  belongs_to :pass

  validate :within_role
  validate :within_level
  validates_presence_of :email, :pass_id

  def self.parse(file)
    result = []
    CSV.foreach(file, headers: true, encoding: 'UTF-8') do |row|
      if (r = Registrant.find_by_email(row[code[:email]])).present?
        result << {name: row[code[:name]], registrant: r, existing: true}
      else
        reg = Registrant.new name: row[code[:name]],
                          email: row[code[:email]],
                          pass: Pass.find_by_name(row[code[:pass]]),
                          partner: row[code[:partner]].present? ? row[code[:partner]] : nil,
                          level: find_level(row[code[:level]]),
                          role: row[code[:role]].try(:downcase)
        if reg.save
          result << {name: row[code[:name]], registrant: reg}
        else
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
      sun_class: "Clase optativa domingo"
    }
  end

  def self.roles
    ['leader', 'follower']
  end

  def self.levels
    ['beginner', 'intermediate', 'advanced']
  end

  private

  def self.find_level(level)
    return nil if level.nil?
    if level.match(/.*spoon.*/)
      'intermediate'
    elsif level.match(/.*first.*/)
      'beginner'
    end
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

end
