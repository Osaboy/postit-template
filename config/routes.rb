PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]  
  end
 
  #get 'photos/poll', to: 'photos#poll'
end
