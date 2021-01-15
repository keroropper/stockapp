Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles, only: [:index, :new, :create] do
    collection do
      get 'search'
    end
  end
end
