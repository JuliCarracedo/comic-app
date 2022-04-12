class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    
    respond_to :json
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user
    
    private

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
    
    def authenticate_user
        @jwt = headers['Authorization'].split.last if headers['Authorization'].present?
        @decoded_auth_token ||= JWT.decode(@jwt, Rails.application.secrets.secret_key_base))
        @user ||= User.find(@decoded_auth_token) if @decoded_auth_token
        rescue ActiveRecord::RecordNotFound 
            head :unauthorized
        end

        # if request.headers['Authorization'].present?
        #     authenticate_or_request_with_http_token do |token|
        #         begin
        #             jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base)
        #             @current_user_id = jwt_payload

        #         rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        #             head :unauthorized
        #         end
        #     end
        # end
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
