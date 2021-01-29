Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles do
    collection do
      get 'search'
    end
    resources :comments, only: :create
    resource :likes, only: [:create, :destroy]
  end
  get 'tags/index' => 'articles#tag_index'

end
