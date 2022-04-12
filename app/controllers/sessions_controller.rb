class SessionsController < Devise::SessionsController
  skip_before_action :authorize_request, :verify_authenticity_token

    def create
      @user = User.find_by_email(params[:email])
      if @user.valid_password?(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                      username: @user.username }, status: :ok
      else
        render json: { error: 'unauthorized'}, status: :unauthorized
      end
    end
end

