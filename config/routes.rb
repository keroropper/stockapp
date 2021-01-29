Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles do
    collection do
      get 'search'
    end
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
<<<<<<< Updated upstream

  # post 'like/:id' => 'likes#create', as: 'create_like'
  # delete 'like/:id' => 'likes#destroy', as: 'destroy_like'

=======
  
  get 'tags/index' => 'articles#tag_index'
>>>>>>> Stashed changes
end
