class UsersController < ApplicationController
    protect_from_forgery with: :null_session

    def update
      if params[:id] && current_user.id === params[:id]
        user = User.find(params[:id])
        vars = {}
        vars.merge(username: params[:username]) if params[:username]
        vars.merge(email: params[:email]) if params[:email]
        vars.merge(password: params[:password]) if params[:password]
        if params[:profile]
          user.profile.purge
          user.profile.attach(params[:profile])
        end
        if user.update(vars)
          render json: {message: "Successfully updated", user: {profile_url: cloudinary_url(user.profile.key, width: 100, height: 100)}}, status: 200
        else
          render json: {error: user.errors}, status: 422
        end
      else
        render json: {error: {user: ["can't be updated by you"]}}, status: 422
      end
    end

    def delete
      if params[:id] && current_user.id === params[:id]
        user = User.find(params[:id])
        user.destroy
        current_user = nil
        render json: {messsage: "Successfully deleted"}, status: 200
      else
        render json: {error: {user: ["can't be deleted by you"]}}, status: 422
      end
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
