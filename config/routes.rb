Rails.application.routes.draw do

  resources :providers, only: [:index, :show] do
    resources :repositories
  end

  resources :accounts, only: [:create]

end
