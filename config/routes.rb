Rails.application.routes.draw do
  # Other routes...
  root 'dashboard#index'  # Set the dashboard as the root page
  get 'dashboard', to: 'dashboard#index'

  # Other resources...
  resources :purchase_orders
  resources :purchase_order_items
  resources :products
  resources :sales_orders
  resources :sales_order_items
  resources :suppliers
  resources :customers
  resources :inventory_items
end
