Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions, registrations: :registrations },
                       path_names: { sign_in: :login }
    resources :users, only: [:show, :update, :delete]
    resources :comics, only: [:show, :create, :update, :delete] do
      get "/followers", to: "followers#list"
      post "/follow", to: "followers#follow"
      delete "/unfollow", to: "followers#unfollow"
    end
    resources :likes, only: [:create, :delete]
    
    # post 'user/upload', to: 'users#upload_profile'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
