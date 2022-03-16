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



    private
end
