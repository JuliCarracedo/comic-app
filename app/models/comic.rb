class Comic < ApplicationRecord
  belongs_to :user
  has_many :followers

  validates :title, presence: true, uniqueness: true, length: {in: 1...30}
  validates :description, presence: true, length: {in: 20...200}

end
