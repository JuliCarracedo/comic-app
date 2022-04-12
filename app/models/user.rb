class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :comics, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :likes, dependent: :destroy

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true, length: {max: 20}, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
  validates :password, presence: true, length: {in: 8...20}


  def generate_jwt
    JWT.encode(id,Rails.application.secrets.secret_key_base)
  end

  def get_profile_link
    url_for(self.image)
  end

end
