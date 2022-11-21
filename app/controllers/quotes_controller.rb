class QuotesController < ApplicationController
    skip_before_action :verify_authenticity_token
    def form
    end
    
    def create
        quote= Quote.new()
        quote.building_type = params[:radio_quote]

        # name and email
        quote.company_name = params[:name_company]
        quote.company_email = params[:email_company]



        # residential
         quote.number_apartments = params[:number_apartments]
         quote.number_floors_residential = params[:number_floors_residential]
         quote.number_basements_residential = params[:number_basements_residential]

        # commercial
         quote.number_distinct_businesses_commercial = params[:number_distinct_businesses_commercial]
         quote.number_floors_commercial = params[:number_floors_commercial]
         quote.number_basements_commercial = params[:number_basements_commercial]
         quote.number_parking_commercial = params[:number_parking_commercial]
         quote.number_elevators = params[:number_elevators]
         quote.number_elevators = params[:number_elevators]
         
         
         #  corporate
         quote.number_separate_companies = params[:number_separate_companies]
         quote.number_floors_corporate = params[:number_floors_corporate]
         quote.number_basements_corporate = params[:number_basements_corporate]
         quote.number_parking_corporate = params[:number_parking_corporate]
         quote.max_number_occupants_floor_corporate = params[:max_number_occupants_floor_corporate]
         
         
         #  hybrid
         quote.number_distinct_businesses_hybrid = params[:number_distinct_businesses_hybrid]
         quote.number_floors_hybrid = params[:number_floors_hybrid]
         quote.number_basements_hybrid = params[:number_basements_hybrid]
         quote.number_parking_hybrid = params[:number_parking_hybrid]
         quote.max_number_occupants_floor_hybrid = params[:max_number_occupants_floor_hybrid]
         quote.number_distinct_businesses_hybrid = params[:number_distinct_businesses_hybrid]
         quote.number_hours_activity = params[:number_hours_activity]

        # produc line
        quote.product_line = params[:product_line]


        #  output
        quote.elevator_need = params[:elevator_need]
        quote.unit_price = params[:unit_price]
        quote.total_price = params[:total_price]
        quote.installation_fees = params[:installation_fees]
        quote.final_price = params[:final_price]



        ticket = "#{params[:name_company]}<br> asked for a quote. This is the result: Number of elevator need #{params[:elevator_need]}<br> Unit price #{params[:unit_price]}<br> Total price #{params[:total_price]}<br>  Installation fees #{params[:installation_fees]}<br> Final price #{params[:final_price]}"

        
        # Your freshdesk domain
        freshdesk_domain = 'codeboxx-support'
        
        # It could be either your user name or api_key.
        user_name_or_api_key = ENV['freshdesk']
        # If you have given api_key, then it should be x. If you have given user name, it should be password
        password_or_x = 'X'
        
        json_payload = { status: 2,  
            priority: 1,
            type: "Feature Request",
            subject: "Quote",
            name: params[:name_company],
            email: params[:email_company],
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

















         



        quote.save()
    end
end
