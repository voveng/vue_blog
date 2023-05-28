# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts do
        resources :comments, only: %i[create update destroy]
      end
      post :sign_up, to: 'users#create'
      post :sign_in, to: 'users#sign_in'
    end
  end
end
