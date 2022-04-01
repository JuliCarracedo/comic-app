class SessionsController < Devise::SessionsController
    def create
      puts ('console check')
      puts(params)
      user = User.find_by_email(params[:email])
      if user && user.valid_password?(params[:password])
        @current_user = user
        render json: { message: 'Logged in', token: user.generate_jwt }, status: :ok
      else
        render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      end
    end
end