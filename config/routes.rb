PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/signout', to: 'sessions#destroy'

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create] 
  end
  
  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:create, :show, :edit, :update] 
 
  #get 'photos/poll', to: 'photos#poll'
end
