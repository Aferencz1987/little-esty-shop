Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  # patch ‘/admins/pet_applications/:id/pets/:pet_id/approved’, to: ‘admin_pet_applications#approved’
  # patch ‘/admins/pet_applications/:id/pets/:pet_id/rejected’, to: ‘admin_pet_applications#rejected’

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants
    post "/merchants/:id", to: "merchants#enabled"
    resources :invoices
  end

  resources :merchants, module: :merchant do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :show]
    resources :invoices
  end
end
