module ApplicationHelper

  def role_label(role)
    case role
    when "leader"
      "Lead"
    when "follower"
      "Follow"
    end
  end

  def level_label(level)
    case level
    when 'beginner'
      "Principiantes"
    when 'intermediate'
      "Intermedios"
    when 'advanced'
      "Avanzados"
    else
      level
    end
  end
end
