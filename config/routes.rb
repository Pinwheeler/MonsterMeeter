Rails.application.routes.draw do
  
  get 'welcome/index'
  get 'encounter_table/index'
  post 'encounter_table/update'
  post 'encounter_table/print'
  
  resources :monsters do
    get 'terrains', on: :member
  end
  
  resources :terrains
  
  root 'welcome#index'
  
end
