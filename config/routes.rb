Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'chat#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show] do 
        resources :conversations, only: [:index, :show, :create] do
          resources :messages, only: [:create]
        end
      end
    end
  end

  mount ActionCable.server => '/cable'
end
