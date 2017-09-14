Rails.application.routes.draw do
  
  resources :databases
  resources :projects
  resources :technologies

  get 'projects/start_project/:name', to: 'projects#start_project'
  get 'projects/stop_project/:name', to: 'projects#stop_project'

  get 'statics/help'

  root 'statics#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
