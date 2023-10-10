Rails.application.routes.draw do
  root to:"homes#top"
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users
  resources :books
  resources :users, only: [:show, :edit, :index]
  resources :post_images, only: [:new, :index, :show]
end
