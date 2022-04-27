class RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token

    def new
        @user = User.new(username: params[:username], email:  params[:email],password: params[:password])
        if @user.valid?
            @user.save
            @current_user = @user
            token = JsonWebToken.encode(user_id: @user.id)
            time = Time.now + 24.hours.to_i
            render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                      user: {id: @user.id} }, status: :ok
        else
            render json: {errors: @user.errors}, status: 401
        end
    end
  end