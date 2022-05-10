class UsersController < ApplicationController
    protect_from_forgery with: :null_session

    def update
      
      if current_user.update()
        current_user.profile.attach(params[:avatar]) if params[:avatar]
        render json: {message: "Successfully updated", user: {profile_url: cloudinary_url(user.profile.key, width: 100, height: 100)}}, status: 200
      else
        render json: {error: current_user.errors}, status: 422
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
