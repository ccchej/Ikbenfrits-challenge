Rails.application.routes.draw do
  root 'pastries#index'
  get 'pastries/index'
  post 'pastries/order'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
