class UsersController < ApplicationController
    protect_from_forgery with: :null_session

    def update
      if params[:id] && current_user.id === params[:id]
        user = User.find(params[:id]).update()
        if 
          user.profile.attach(params[:avatar]) if params[:avatar]
          render json: {message: "Successfully updated", user: {profile_url: cloudinary_url(user.profile.key, width: 100, height: 100)}}, status: 200
        else
          render json: {error: user.errors}, status: 422
        end
      else
        render json: {error: {user: ["can't be updated by you"]}}, status: 422
      end
    end

    def delete
      current_user.destroy
      current_user = nil;
      render json: {messsage: "Successfully deleted"}, status: 200
    end

    def show
      if params[:id]
        user = User.find(params[:id])
        if user
          render json: {user: {profile_url: cloudinary_url(user.profile.key, width: 100, height: 100)}}, status: 200
        else
          render json: {error: {user:["not found"]}}, status: 422
        end
      end
    end
end
