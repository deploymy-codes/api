Rails.application.routes.draw do

  resources :providers, only: :index

end
