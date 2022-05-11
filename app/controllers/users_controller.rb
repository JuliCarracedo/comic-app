class UsersController < ApplicationController
    include CloudinaryHelper
    protect_from_forgery with: :null_session
    before_action :authorize_request

    def update
      if params[:id] && @current_user.id === params[:id].to_i
        if @current_user.update(update_params)
          render json: {message: "Successfully updated"}, status: 200
        else
          render json: {error: @current_user.errors}, status: 422
        end
      else
        render json: {error: {user: ["can't be updated by you"]}}, status: 422
      end
    end

    def update_profile
      # if params[:user_id] && @current_user.id === params[:user_id].to_i
      #   if @current_user.profile.attach(profile_params[:profile])
      #     render json: {message: "Profile successfully updated",user: @current_user.profile.attach(params[:profile])}, status: 200
      #   else
      #     render json: {error: @current_user.errors}, status: 200
      #   end
      # else
      #   render json: {error: {user: ["can't be updated by you"]}}, status: 422
      # end
      @current_user.update(profile: params[:profile]) if params[:profile]
      render json: {key: cloudinary_url(@current_user.profile.key, width: 100, height: 100)}, status: 200
    end

    def delete
      if params[:id] && @current_user.id === params[:id].to_i
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
          render json: {user: {profile_url: cloudinary_url(user.profile.key)}}, status: 200
        else
          render json: {error: {user:["not found"]}}, status: 422
        end
      end
    end

    private 
    
    def update_params
      params.permit(:password, :username, :new_password, :email)
    end

end
