class User < ApplicationRecord
  has_many :profiles,dependent: :delete_all
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 

  VALID_ROLES = ['user','admin']
  validates :role, presence: true, inclusion:{in:VALID_ROLES}
  def generate_jwt
    JWT.encode({ id: id,
                exp: 30.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end
end
