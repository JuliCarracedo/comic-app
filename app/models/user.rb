class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :comics, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :profile
  validate :password_format, :email_format
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true, length: {maximum: 20}, presence: true, on: [:create, :update]
  validates :email, uniqueness: true, presence: true, on: [:create, :update]
  validates :password, length: {in: 6...20}, presence: true, on: [:create, :update]

  def generate_jwt
    JWT.encode(id,Rails.application.secrets.secret_key_base)
  end

  def password_format
    if password
      unless password.match(/[a-z]/)
        errors.add(:password, "Must contain one or more lowercase letters");
      end
      unless password.match(/[A-Z]/)
        errors.add(:password, "Must contain one or more uppercase letters");
      end
      unless password.match(/[0-9]/)
        errors.add(:password, "Must contain one or more numbers");
      end
    end
  end

  def email_format 
    if email
      unless email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
        errors.add(:email, "Must follow the 'example@example.com' format");
      end
    end
  end
  

end
