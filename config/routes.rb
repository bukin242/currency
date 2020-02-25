Rails.application.routes.draw do
  root to: 'currency#index'

  namespace :admin do
    resources :custom_rate, only: %i[new create]
  end
end
