Rails.application.routes.draw do
  get 'dashboard/index'
  resources :products
  resources :suppliers
  resources :customers
  resources :orders
  resources :stock_adjustments

  root "dashboard#index"
end