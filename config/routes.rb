Rails.application.routes.draw do
  get 'orders/index'
  devise_for :borrowers
  devise_for :borrowees
  resources  :borrowees, only: [:index, :show]
  resources  :borrowers, only: [:index, :show]
  resources  :products
  resources  :orders
  resources  :order_items, only: [:new, :create, :edit, :update, :destroy]
  resources  :searches, only: [:new, :create, :show]
  resources  :checkouts, only: [:new, :create, :show]
  # resources  :borrowers
  root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
