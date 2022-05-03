class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

    def create
      @user = User.find_by_email(params[:email])
      if @user.valid_password?(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                      user: {id: @user.id, username: user.username}, message: "Successfully Logged In" }, status: :ok
      else
        render json: { errors: {wrong:["email or password"]}}, status: :unauthorized
      end
    end
end

