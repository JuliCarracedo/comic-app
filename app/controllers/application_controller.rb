class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    
    respond_to :json
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authorize_request
    
    private

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

      def not_found
        render json: { error: 'not_found' }
      end
    
      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = JsonWebToken.decode(header)
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
      end

    def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
    end

    def current_user
    @current_user ||= super || User.find(@current_user_id)
    end

    def signed_in?
    @current_user_id.present?
    end

end
