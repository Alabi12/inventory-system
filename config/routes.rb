Rails.application.routes.draw do
  get 'reports/inventory'
  get 'reports/reorder_points'
  get 'reports/stock_movements'
  get 'reports/sales'

  resources :reports, only: [] do
    collection do
      get :sales
    end
  end
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
