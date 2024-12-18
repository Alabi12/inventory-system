Rails.application.routes.draw do
  resources :stores
  #  root 'home#index'
  devise_for :users
  get 'reports/inventory'
  get 'reports/reorder_points'
  get 'reports/stock_movements'
  get 'reports/sales'
  get 'reports/inventory_analysis', to: 'reports#inventory_analysis', as: 'analysis_inventory'

  resources :stock_movements

  resources :reports, only: [] do
    collection do
      get :sales
      get :stock_movement
    end
  end
  
  resources :purchase_orders do
    resources :purchase_order_items
  end

  resources :sales_orders do
    resources :sales_order_items, only: [:index, :show]
  end
  
  resources :inventory_items, only: [:new, :create] do
    member do
      patch :update_closing_inventory
    end
  end
  
  # Other routes...
  root 'dashboard#index'  # Set the dashboard as the root page
  get 'dashboard', to: 'dashboard#index'
  
  # Other resources...
  resources :purchase_orders
  resources :purchase_order_items
  resources :products
  resources :suppliers
  resources :customers
  resources :sales_orders
  resources :sales_order_items

  resources :warehouses
end
