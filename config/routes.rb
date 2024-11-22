Rails.application.routes.draw do
  get 'reports/inventory'
  get 'reports/reorder_points'
  get 'reports/stock_movements'
  get 'reports/sales'

  resources :stock_movements, only: [:index, :new, :create]

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
  
  # Other routes...
  root 'dashboard#index'  # Set the dashboard as the root page
  get 'dashboard', to: 'dashboard#index'
  
  # Other resources...
  resources :purchase_orders
  resources :purchase_order_items
  resources :products
  resources :suppliers
  resources :customers
  resources :inventory_items
  resources :sales_orders
  resources :sales_order_items
end
