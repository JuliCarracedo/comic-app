class FollowersController < ApplicationController
    before_action :authenticate_user!
    def list
        followed = Follower.where(user_id: current_user_id).map(follower => follower.comic)
        render json: {followed_comics: followed}, status:200
    end
end