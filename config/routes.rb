PostitTemplate::Application.routes.draw do
  root to: 'post#index'
  resources :posts, except: [:destroy]
end
