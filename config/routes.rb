Rails.application.routes.draw do
  devise_for :users
  root 'invoices#index'
  resources :invoices
  
  resources :clients, only: [] do
    member do
      get :info
    end
    collection do
      get :lookup
    end
  end

end
