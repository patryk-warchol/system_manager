Rails.application.routes.draw do
  get 'statics/home'

  get 'statics/help'

  root 'statics#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
