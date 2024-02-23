Rails.application.routes.draw do


  devise_for :users


  root to: 'home#top'
  get 'home/about', as: 'about'


  resources :books, only: [:index, :create, :show, :edit, :destroy, :update] do
  resource :favorite, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
end

  resources :users, only: [:index, :show, :edit, :update, :destroy]
end
