Rails.application.routes.draw do
  devise_for :borrowers
  devise_for :borrowees
  resources  :borrowees
  resources  :products
  resources  :order_items
  resources  :orders
  # resources  :borrowers
  root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
