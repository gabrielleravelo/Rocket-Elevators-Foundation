require 'rubygems'
require 'rest-client'
require 'json'
require 'sendgrid-ruby'
include SendGrid

class LeadsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
    end

    def create
        
        @lead= Lead.new()
        @lead.full_name_contact = params[:full_name_contact]
        @lead.company_name = params[:company_name]
        @lead.email = params[:email]
        @lead.phone = params[:phone]
        @lead.project_name = params[:project_name]
        @lead.project_description = params[:project_description]
        @lead.department_elevator = params[:department]
        @lead.message = params[:message]
        @lead.attached_file = params[:attachment]
 
        @lead.save()

        # Deliver the contact us email
       
        LeadNotifierMailer.send_contactus_email(@lead).deliver_now


        
        
        #freshdesk
        full_name_contact = params[:full_name_contact]
        company_name = params[:company_name]
        email = params[:email]
        phone = params[:phone]
        department = params[:department]
        project_name = params[:project_name]
        description = params[:project_description]
        message = params[:message]
        
        
        
        
        
        
        ticket = "Subject:  #{full_name_contact } <br>  from   #{company_name}<br>   Comment: The contact  #{full_name_contact}<br> from company  #{company_name}<br>can be reached at email   #{email}<br>  and at phone number  #{phone}<br>    #{department}<br>  has a project named  #{project_name}<br> which would require contribution from Rocket Elevators.   #{description}<br>
        Attached Message:   #{message}"
        
        #Create a ticket with cc_emails attributes.
        
        
        # Your freshdesk domain
        freshdesk_domain = 'codeboxx-support'
        
        # It could be either your user name or api_key.
        user_name_or_api_key = ENV['freshdesk']
        # If you have given api_key, then it should be x. If you have given user name, it should be password
        password_or_x = 'X'
        
        json_payload = { status: 2,  
            priority: 1,
            type: "Question",
            subject: "contact",
            email: params[:email],
            description: ticket
        }.to_json
        
        freshdesk_api_path = 'api/v2/tickets'
        
        freshdesk_api_url  = "https://#{freshdesk_domain}.freshdesk.com/#{freshdesk_api_path}"
        
        site = RestClient::Resource.new(freshdesk_api_url, user_name_or_api_key, password_or_x)
        
        begin
            response = site.post(json_payload, :content_type=>'application/json')
            puts "response_code: #{response.code} \n Location Header: #{response.headers[:location]}\n response_body: #{response.body}"
        rescue RestClient::Exception => exception
            puts 'API Error: Your request is not successful. If you are not able to debug this error properly, mail us at support@freshdesk.com with the follwing X-Request-Id'
            puts "X-Request-Id : #{exception.response.headers[:x_request_id]}"
            puts "Response Code: #{exception.response.code} Response Body: #{exception.response.body} "
        end

        
        
         
             
    
    
    
    
        
        
    
    end

end

