class Chapter < ApplicationRecord
  belongs_to :comic

  validates :title, presence: true, length: {in: 1...30}
  validates :description, presence: true, length: {in: 10...100}
end
