class UsersController < ApplicationController
    before_action :authenticate_user!
    protect_from_forgery with: :null_session

      def show
        @resource = current_user
        respond_with @resource do |format|
          # format.html { send_data @resource.body } # => Download the image file.
          format.json { send_data @resource.image,
                        type: 'image/png' || 'image/jpeg',
                        disposition: 'inline' } # => Show in browser page.
      end
    end

    # def update
    #   if current_user.update_attributes(user_params)
    #     render :show
    #   else
    #     render json: { errors: current_user.errors }, status: :unprocessable_entity
    #   end
    # end
    def update
      if current_user.update(user_params)
        render json: {message: "Successfully updated"}, status: 200
      else
        render json: {error: current_user.errors}, status: 422
      end
    end

    def delete
      current_user.destroy
      current_user = nil;
      render json: {messsage: "Successfully deleted"}, status: 200
    end

    private
    def user_params
      params.require(:user).permit(:username)
    end
end
