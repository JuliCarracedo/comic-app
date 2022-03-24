class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :image, dependent: :destroy
  has_many :comics
  has_many :followers, as: :following
  has_many :likes

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true, length: {max: 20}, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
  validates :password, presence: true, length: {in: 8...20}


  def generate_jwt
    JWT.encode({ id: id,
                exp: 60.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end

  def get_profile_link
    url_for(self.image)
  end

end
