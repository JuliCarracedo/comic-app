Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions, registrations: :registrations },
                       path_names: { sign_in: :login }
    resource :users, only: [:show, :update, :delete]
    resource :comics, only: [:show, :create, :update, :delete]
    get "/followed", to "follower#list"
    # post 'user/upload', to: 'users#upload_profile'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
