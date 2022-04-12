class RegistrationsController < Devise::RegistrationsController
    protect_from_forgery with: :null_session
    skip_before_action :authenticate_user

    def new
        @user = User.new(username: params[:username], email:  params[:email],password: params[:password])
        if @user.valid?
            @user.save
            @current_user = @user
            render json: {message: "successfully created", user: @user, token: @user.generate_jwt}, status: 200
        else
            render json: {errors: @user.errors}, status: 401
        end
    end
  end