require 'dropbox_api'
require 'slack-ruby-client'
require Rails.root.join('lib', 'rails_admin', 'customer_map.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::CustomerMap)


RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
    config.authenticate_with do
      warden.authenticate! scope: :user
    end
    config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    customer_map
    # playAudio

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
  # config.model Team do
  #   configure :name do
  #     label "Team's name"
  #   end
  # end

end