Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  get  "/top_commenters", to: "home#ranking"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
      post :create_comment
      delete :destroy_comment
    end
    collection do
      get :export
    end
  end
end
