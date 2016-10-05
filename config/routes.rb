Rails.application.routes.draw do
  resource :transaction, only: [:show, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#show'
end
