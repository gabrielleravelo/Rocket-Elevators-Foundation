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

  # Interventions request 
  get '/interventions', to: 'interventions#interventionform'

  #graphsql
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end

  post "/graphql", to: "graphql#execute"
end


