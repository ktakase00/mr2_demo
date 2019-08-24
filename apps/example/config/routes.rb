Rails.application.routes.draw do
  resources :reservations
  resources :meeting_rooms
  resources :users
  resources :sessions, only: [ :new, :create, :destroy ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
