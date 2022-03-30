class Follower < ApplicationRecord
  belongs_to :user, inverse_of: :following
  belongs_to :comic, inverse_of: :followers

  validate :is_not_owner

  private

  def is_not_owner
    if current_user.id === user_id
      errors.add(:user, "can't follow your own commic")
    end
  end

end
