Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions, registrations: :registrations },
                       path_names: { sign_in: :login }
    resource :user, only: [:show, :update]
    post 'user/upload', to: 'users#upload_profile'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
