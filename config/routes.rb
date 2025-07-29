Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :documents do
        post :create
      end
    end
  end

  resources :documents do
    post :create
  end

  root 'documents#index'
end
