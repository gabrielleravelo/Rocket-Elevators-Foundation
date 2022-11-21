class CustomerMapController < ApplicationController
  before_action :authenticate_user!
  
    def customer_map
   test()
    end
    def test
        @nb_customer_addresses = 0
        @customer_lat = []
        @customer_lng = []
        @client_name = []
        @customer_addresses = []
        @nb_batteries = []
        @nb_columns = []
        @nb_elevator = []
        @contac_name = []
        Customer.all.each  do |customer|
            nb_batteries = 0
            nb_columns = 0
            nb_elevator = 0

            @customer_lat.push(customer.address.lat)   
            @customer_lng.push(customer.address.lng)

            @nb_customer_addresses += 1
            @client_name.push(customer.company_name)

            address =  Address.find(customer.address_id)
            @customer_addresses.push(address.number_and_street)

            customer.buildings.all.each do |building|
              nb_batteries += building.batteries.count
              @contac_name.push(building.technicalContactFullName)

              building.batteries.all.each do |battery|
                nb_columns += battery.columns.count
                
                battery.columns.all.each do |column|
                  nb_elevator += column.elevators.count
                  
                  puts column.elevators.count, "===================================="
                end 
              end
            end
            
            @nb_batteries.push(nb_batteries)
            @nb_columns.push(nb_columns)
            @nb_elevator.push(nb_elevator)
          end

        





   
   end
 end
 
