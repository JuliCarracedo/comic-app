class FollowersController < ApplicationController
    before_action :authenticate_user!
    def list
        followed = Follower.where(user_id: current_user.id).map{|follower| follower.comic}
        render json: {followed_comics: followed}, status:200
    end
    def follow
        if Follower.find_by(user_id: current_user.id, comic_id: params[:comic_id])
            render json: {error: "Already followed"}, status:422
        else
            follower.new(user_id: current_user.id, comic_id: params[:comic_id])
            if follower.save
                render json: {message: "Comic Followed Successfully"}, status:200
            end
        end
    end
end