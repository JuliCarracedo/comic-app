class Comic < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: {in: 1...30}
  validates :description, presence: true, length: {in: 20...200}

end
