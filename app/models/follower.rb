class Follower < ApplicationRecord
  belongs_to :user, inverse_of: :following
  belongs_to :comic, inverse_of: :followers
end
