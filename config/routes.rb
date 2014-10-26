Rails.application.routes.draw do
  scope format: true, constraints: { format: 'json' } do
    resources :providers, only: :index
  end
end
