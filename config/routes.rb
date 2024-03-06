Rails.application.routes.draw do
  get 'boletos/index'
  get 'boletos/show'
  get 'boletos/new'
  get 'boletos/create'
  get 'boletos/edit'
  get 'boletos/update'
  get 'boletos/destroy'

  get "up" => "rails/health#show", as: :rails_health_check

  Rails.application.routes.draw do
    resources :boletos
    root 'boletos#index'
  end  
end
