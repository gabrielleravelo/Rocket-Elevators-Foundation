require 'rubygems'
require 'rest_client'
require 'json'


class InterventionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def interventionform
  end
  
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
    
    intervention= Intervention.new()
    intervention.author = current_employee.id
    intervention.customerId = params[:name_company]
    intervention.buildingId = params[:building_customer]
    intervention.batteryId = params[:battery_customer]
    intervention.columnId = params[:column_customer] == "0" ? nil : params[:column_customer]
    intervention.elevatorId = params[:elevator_customer] == "0" ? nil : params[:elevator_customer]
    intervention.employeeId = params[:employeename] #== "0" ? nil : params[:employeename]
    intervention.report = params[:description]
    intervention.save()


    # Freshdesk
    requester = current_employee
    requester_fullname = "#{requester.first_name} #{requester.last_name}"
    customer = Customer.find(params[:name_company])
    buildingID = params[:building_customer]
    batteryID = params[:battery_customer]
    

    if params[:column_customer] != "0"
      columnID = params[:column_customer]
    else
      columnID = "None"
      elevatorID = "None"
    end

    if elevatorID = params[:elevator_customer] != "0"
      elevatorID = params[:elevator_customer]
    else
      elevatorID = "None"
    end

    if params[:employeename] != ""
      employee_assigned = Employee.find(params[:employeename])
      employee_assigned_fullname = "#{employee_assigned.first_name} #{employee_assigned.last_name}"
    else
      employee_assigned_fullname = "None"
    end
    
    description = params[:description]

    
    ticket = "#{requester_fullname} has sent an intervention request for the customer #{customer.company_name}.<br> 
            The building ID is #{buildingID}.<br> The battery ID is #{batteryID}.<br>
            The column ID is #{columnID}.<br> The elevator ID is #{elevatorID}.<br>
            The employee to be assigned to the task is #{employee_assigned_fullname}<br>
            Description of the request for intervention: #{description}<br>"


    # Your freshdesk domain
    freshdesk_domain = 'rocketelevator-helpdesk'

    # It could be either your user name or api_key.
    user_name_or_api_key = ENV['FRESHDESK_KEY']

    # If you have given api_key, then it should be x. If you have given user name, it should be password
    password_or_x = 'X'

    
    json_payload = { 
        status: 2,  
        priority: 1,
        type: "Incident",
        subject: "Request",
        name: requester_fullname,
        email: requester.email,
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

