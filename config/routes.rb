# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end
  devise_for :users, :controllers => { registrations: 'registrations' }
  namespace :admins_backoffice do
    get 'welcome/index'
    resources :admins
    resources :subjects
    resources :questions
  end
  devise_for :admins, :skip => [:registrations]
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    post 'answer', to: 'answer#question'
    get 'subject/:subject_id/:subject', to: 'search#subject', as: 'search_subject'
  end

  get '/admin', to: 'admins_backoffice/welcome#index'
  root to: 'site/welcome#index'
  
end
