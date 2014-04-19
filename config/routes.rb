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
    
    member do
      post :vote
    end

=begin
    #GET /posts/archives
    collection do
      get :archives
    end      
=end
   
    resources :comments, only: [:create] do
      member do
        post :vote
      end
    end

  end
  
  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:create, :show, :edit, :update] 
 
  #get 'photos/poll', to: 'photos#poll'
end

=begin
How to route the votes

1) If voting on alot of stuff do this
POST /votes => 'VotesController#create'
- the form will need to pass 2 pieces of information
resources :votes, only: [:create]

2)
POST /post/3/vote => 'PostsController#vote'
POST /comments/4/vote => 'CommentsController#vote'

=end 

