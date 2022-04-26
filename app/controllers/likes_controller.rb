class LikesController < ApplicationController
    before_action :authorize_request
    def create 
        if params[:comic_id] && Comic.find(params[:comic_id]).user_id != current_user.id
            Like.create(user_id: @current_user.id, comic_id: params[:comic_id])
            render json: {message:"You liked this comic"}, status: 200
        elsif !params[:comic_id]
            render json: { error: {comic:["doesn't exist"]} }, status: 422
        else
            render json: { error: {user:["Can't like their own comic"]} }, status: 422
        end
    end

    def destroy 
        if params[:comic_id] 
            like = Like.where(user_id: current_user.id, comic_id: params[:comic_id])
            if like
                like.delete
                render json: {message:"You disliked this comic"}, status: 200
            end
        end
    end

    def your_likes 
        liked_comics = @current_user.likes.map{|like| like.comic}
        render json: {comics: liked_comics}, status: 200
    end

    def count
        likes = Comic.find(params[:comic_id]).likes.length
        render json: {likes: likes}, status: 200
    end
end