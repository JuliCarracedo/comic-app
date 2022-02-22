class RegistrationsController < Devise::RegistrationsController

    def new
        @user = User.new(username: params[:username], email:  params[:email],password: params[:password])
        if @user.valid?
            @user.save
            @current_user = @user
            render json: {message: "successfully created"}, status: 200
        else
            render json: {errors: @user.errors}, status: 401
        end
    end
  end