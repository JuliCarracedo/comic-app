class UsersController < ApplicationController
    protect_from_forgery with: :null_session

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

    def show
      if params[:id]
        user = User.find(params[:id])
        if user
          display = {username: user.username, thumbnail_url: user.thumbnail_url}
          render json: {user: display}, status: 200
        else
          render json: {error: {user:["not found"]}}, status: 422
        end
      end
    end

    private
    def user_params
      params.require(:user).permit(:username)
    end
end
