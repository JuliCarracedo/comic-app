class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :comics, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :likes, dependent: :destroy
  validate :password_format
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true, length: {max: 20}, allow_blank: false,
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
  validates :password, presence: true, length: {in: 6...20}


  def generate_jwt
    JWT.encode(id,Rails.application.secrets.secret_key_base)
  end

  def get_profile_link
    url_for(self.image)
  end

  def password_format
    unless /[a-z]/
      errors.add(:password, "Must contain one or more lowercase letters");
    end
    unless /[A-Z]/
      errors.add(:password, "Must contain one or more uppercase letters");
    end
    unless /[0-9]/
      errors.add(:password, "Must contain one or more numbers");
    end
  end

end
