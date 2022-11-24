require 'rubygems'
require 'rest_client'
require 'json'


class InterventionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def interventionform
    # @customers = Customer.all
    # @buildings = Building.where("customer_id = ?", Customer.first.id)
  end

  # def show
  #   @building = Building.find_by("id = ?", params[:building_id])
  # end
  
  def getBuildingByCustomer
    @buildings = Building.where(customer_id: params[:id])

    respond_to do |format|
      format.json { render json: @buildings.to_json, status: 200 }
      format.html
    end
  end 

  def getBatteryByBuilding
    @batteries = Battery.where(building_id: params[:building])

    respond_to do |format|
      format.json { render json: @batteries.to_json, status: 200 }
      format.html
    end
  end 

  def getColumnByBattery
    @columns = Column.where(battery_id: params[:battery])

    respond_to do |format|
      format.json { render json: @columns.to_json, status: 200 }
      format.html
    end
  end

  def getElevatorByColumn
    @elevator = Elevator.where(column_id: params[:column])

    respond_to do |format|
      format.json { render json: @elevator.to_json, status: 200 }
      format.html
    end
  end

  def create
    current_employee = current_user.employee
    @intervention= Intervention.new()
    @intervention.author = current_employee.id
    @intervention.customerId = params[:name_company]
    @intervention.buildingId = params[:building_customer]
    @intervention.batteryId = params[:battery_customer]
    @intervention.columnId = params[:column_customer]
    @intervention.elevatorId = params[:elevator_customer]
    # Si None doit être Null
    @intervention.employeeId = params[:employeename]
    # Default value = Incomplete
    # @intervention.result = params[:message]
    @intervention.report = params[:description]
    # Default value = Pending
    # @intervention.status = "Pending"

    @intervention.save()


    # Freshdesk
    requester = current_employee
    customer = Customer.find(params[:name_company])
    buildingID = params[:building_customer]
    columnID = params[:column_customer]
    batteryID = params[:battery_customer]
    elevatorID = params[:elevator_customer]
    employee_assigned = Employee.find(params[:employeename])
    description = params[:description]

    
    ticket = "#{requester.first_name} #{requester.last_name } send an intervention request for the customer #{customer.company_name}.<br> 
            The building ID is #{buildingID},<br> The column ID is #{columnID}.<br>
            the battery ID #{batteryID},<br>  the elevator ID #{elevatorID}.<br>
            #{employee_assigned.first_name} #{employee_assigned.last_name} is assigned to the task.<br>
            Intervention description: #{description}<br>"


    # Your freshdesk domain
    freshdesk_domain = 'rocketelevator-helpdesk'

    # It could be either your user name or api_key.
    user_name_or_api_key = ENV['FRESHDESK_KEY']

    # If you have given api_key, then it should be x. If you have given user name, it should be password
    password_or_x = 'X'

    
    json_payload = { status: 2,  
        priority: 1,
        type: "Incident",
        subject: "Request",
        name: requester.first_name,
        unique_external_id: requester.first_name,
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

