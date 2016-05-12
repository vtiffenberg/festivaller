class RegistrationsController < Devise::RegistrationsController

  protected
    def after_update_path_for(resource)
      puts "AM I HERE"
      settings_path
    end
end
