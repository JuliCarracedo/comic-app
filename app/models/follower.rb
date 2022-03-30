class Follower < ApplicationRecord
  belongs_to :user
  belongs_to :comic, inverse_of: :followers

  validate :is_not_owner

  private

  def is_not_owner
    if Comic.find(comic_id).user_id === user_id
      errors.add(:user, "can't follow your own comic")
    end
  end

end
