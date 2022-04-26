class FollowersController < ApplicationController
    before_action :authorize_request
    def list
        followers = Follower.where(comic_id: params[:comic_id]).map{|follower| follower.comic}
        render json: {followers: followers}, status:200
    end

    def follow
        if Follower.find_by(user_id: @current_user.id, comic_id: params[:comic_id])
            render json: {errors: {comic: ["Already followed"]}}, status:422
        else
            follower = Follower.new(user_id: @current_user.id, comic_id: params[:comic_id])
            if follower.save
                render json: {message: "Comic Followed Successfully"}, status:200
            else
                render json: {errors: follower.errors}, status:422
            end
        end
    end
    
    def unfollow
        follow = Follower.find_by(user_id: @current_user.id, comic_id: params[:comic_id])

        follow.destroy if follow
        render json: {message: "Successfully Unfollowed"}, status:200 if follow

    end
end