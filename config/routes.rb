Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions, registrations: :registrations },
                       path_names: { sign_in: :login }
    resources :users, only: [:show, :update, :destroy] do
      get "/comics", to: "comics#index"
    end
    resources :comics, only: [:show, :create, :update, :destroy] do
      get "/followers", to: "followers#list"
      post "/follow", to: "followers#follow"
      delete "/unfollow", to: "followers#unfollow"
      get "/likes", to: "likes#count"
      post "/like", to: "likes#create"
      delete "/dislike", to: "likes#destroy"
    end
    get "your_likes", to: "likes#your_likes"
    # post 'user/upload', to: 'users#upload_profile'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
