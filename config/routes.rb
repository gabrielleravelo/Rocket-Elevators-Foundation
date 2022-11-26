Rails.application.routes.draw do
  
  # get 'interventions/interventionform'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'corporate', to: 'home#corporate'
  get 'residential', to: 'home#residential'
  
  root 'home#index' # shortcut for the above /


  # root 'quotes#form'
  get '/quotes', to: 'quotes#form'
  post '/quotes', to: 'quotes#create'

  
  # root 'leads#form'
  get '/leads', to: 'leads#form'
  post '/leads', to: 'leads#create'

  

  # get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'home' => 'home#index' 

  # google map 

  get '/customer_map', to: 'customer_map#customer_map'


  get '/audioPage', to: 'audio#audio'
  get '/playAudio', to: 'audio#playAudio'

  

  #graphsql
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end

  post "/graphql", to: "graphql#execute"

  # Interventions request 
  get '/interventions', to: 'interventions#interventionform'
  # get '/interventions/:id', to: 'interventions#getBuildingByCustomer'
  get '/getBuildingByCustomer/:id', to: 'interventions#getBuildingByCustomer'
  get '/getBatteryByBuilding/:building', to: 'interventions#getBatteryByBuilding'
  get '/getColumnByBattery/:battery', to: 'interventions#getColumnByBattery'
  get '/getElevatorByColumn/:column', to: 'interventions#getElevatorByColumn'
  get '/interventions', to: 'interventions#form'
  post '/interventions', to: 'interventions#create'
  resources :interventions

end
