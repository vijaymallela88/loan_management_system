Rails.application.routes.draw do
  # get 'loans/index'
  # get 'loans/new'
  # get 'loans/edit'
  # get 'loans/show'
  resources :loans

  root "loans#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
