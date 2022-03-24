class LikesController < ApplicationController
    before_action :authenticate_user!

    def create 
        if params[:comic_id]
            Like.create(user_id: current_user.id, comic_id: params[:comic_id])
            render json: {message:"You liked this comic"}, status: 200
        end
    end

    def destroy 
        if params[:id]
            Like.find(params[:id]).destroy
            render json: {message:"You disliked this comic"}, status: 200
        end
    end

end