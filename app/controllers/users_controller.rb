class UsersController < ApplicationController
    before_action :authenticate_user!
    protect_from_forgery with: :null_session
    def show
        
    end

    # def update
    #   if current_user.update_attributes(user_params)
    #     render :show
    #   else
    #     render json: { errors: current_user.errors }, status: :unprocessable_entity
    #   end
    # end

    def upload_profile
      if current_user.image
        current_user.image.purge
        current_user.image.build(:image => params[:image])
        render json: {message: 'Profile Picture updated'}, status: :ok
      else
        current_user.image.build(:image => params[:image])
        render json: {message: 'Profile Picture uploaded'}, status: :ok
      end
    end

    private
end
