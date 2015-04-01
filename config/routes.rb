Rails.application.routes.draw do
  
  get 'welcome/index'
  
  resources :monsters
  
  root 'welcome#index'
  
end
