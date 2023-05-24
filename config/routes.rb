Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts do
        resources :comments, only: %i[create update destroy]
      end
    end
  end
end
