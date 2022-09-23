Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'users#index'
  # get 'users/index'
  # get 'users/show'
  # get 'posts/index'
   get 'posts/new', to: 'posts#new', as: 'new_post' # new
  # post 'posts', to: 'posts#create' # create
  get 'users/:user_id/posts/:post_id/comments/new', to: 'comments#new', as: 'new_comment' # new
  post 'users/:user_id/posts/:post_id/comments', to: 'comments#create' # create
  # get 'posts/show'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create show] do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[new create]
    end
  end
end
