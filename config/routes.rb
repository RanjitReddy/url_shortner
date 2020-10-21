Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :short_links
  get ':slug', to: 'short_links#show', as: :short
  root to: 'short_links#index'
end
