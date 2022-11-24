class InterventionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def interventionform
    @customers = Customer.all
    @buildings = Building.where("customer_id = ?", Customer.first.id)
  end

  def show
    @building = Building.find_by("id = ?", params[:building_id])
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
    @intervention= Intervention.new()
    # @intervention.author = params[:full_name_contact]
    @intervention.customerId = params[:customer_id]
    @intervention.buildingId = params[:building_customer]
    @intervention.batteryId = params[:battery_customer]
    @intervention.columnId = params[:column_customer]
    @intervention.elevatorId = params[:elevator_customer]
    # Si None doit être Null
    # @intervention.employeeId = params[:employeeid]
    # Default value = Incomplete
    # @intervention.result = params[:message]
    @intervention.report = params[:description]
    # Default value = Pending
    # @intervention.status = params[:message]

    @intervention.save()
  end
end

