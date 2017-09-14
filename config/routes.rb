Rails.application.routes.draw do
  
  resources :databases
  resources :projects
  resources :technologies

  get 'projects/start_project/:id', to: 'projects#start_project'
  get 'projects/stop_project/:id', to: 'projects#stop_project'

  get 'statics/help'

  root 'statics#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
