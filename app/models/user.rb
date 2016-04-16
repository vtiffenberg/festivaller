class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :validatable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :registerable
end
