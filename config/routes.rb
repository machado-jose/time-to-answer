# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  namespace :users_backoffice do
    get 'welcome/index'
  end
  devise_for :users
  namespace :admins_backoffice do
    get 'welcome/index'
    resources :admins, only: [:index, :edit] 
  end
  devise_for :admins
  namespace :site do
    get 'welcome/index'
  end

  get '/inicio', to: 'site/welcome#index'
  root to: 'site/welcome#index'
end
