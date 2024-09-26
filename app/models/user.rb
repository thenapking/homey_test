class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, inverse_of: :user
  has_many :project_comments, inverse_of: :user
  has_many :project_statuses, inverse_of: :user

end
