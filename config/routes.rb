Rails.application.routes.draw do
  
  resources :databases
  resources :projects
  resources :technologies

  get 'statics/help'

  root 'statics#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
