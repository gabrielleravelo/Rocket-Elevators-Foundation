require 'pg'

namespace :datawarehouse do
    task fact: :environment do
        Elevator.all.each do |elevator|
            FactElevator.create!(
                serial_number: elevator.serial_number,
                date_of_commissioning: elevator.date_commissioning,
                building_id: elevator.column.battery.building_id,
                customer_id: elevator.column.battery.building.customer_id,
                building_city: elevator.column.battery.building.customer.address.city)
            end


        Customer.all.each do |customer|
            elevator_count = 0
             customer.buildings.all.each do |building|
                 building.batteries.all.each do |batterie|
                    batterie.columns.all.each do |column|
                       elevator_count += 1
                    end
                 end
            end
                DimCustomer.create!(
                creation_date: customer.customers_creation_date,
                company_name: customer.company_name,
                fullname_company_main_contact: customer.fullname_company_contact,
                email_company_main_contact: customer.email_company_contact,
                customer_city: customer.address.city,
                 nb_elevators:  elevator_count
                   )
        end
    
        Quote.all.each do |quote|
            FactQuote.create!(
                
                quote_id: quote.id,
                creation: quote.created_at,
                nb_elevator: quote.elevator_need,
                company_name: quote.company_name,
                email: quote.company_email

            )
        end

    
        Lead.all.each do |contact|
            FactContact.create!(
                contactid: contact.id,
                creationdate: contact.created_at,
                companyname: contact.company_name,
                email: contact.email,
                projectname: contact.project_name
            )
        end

    
# fact intervention


# generate fake and random data
employees_id = []
Employee.all.each do |employee|
    employees_id.push(employee.id)  
end
Building.all.each do |building|
    stateList = ["null","batterie","column","elevator"]
    status = ["Pending","InProgress","Interrupted","Resumed","Complete"]
    state = stateList[rand(0..3)]
    if state == "null"
        
    elsif state == "batterie"
        batterie_status = status[rand(0..((status.length() - 1)))]
        if batterie_status == "Complete"
            FactIntervention.create!(
                employeeId: employees_id[rand(0..(employees_id.length() - 1))],
                buildingId: building.id,
                batteryId:  building.batteries.ids[rand(0..(building.batteries.ids.length() - 1))],
                interventionStartAt: Faker::Date.between(from: '2021-09-25', to: '2022-09-25'),
                interventionEndAt: Faker::Date.between(from: '2020-09-23', to: '2021-09-25'),
                report: Faker::VulnerabilityIdentifier.cve,
                result: Faker::ElectricalComponents.electromechanical,
                status: "Complete"
            )
        else
                    status.delete("Complete")
                    FactIntervention.create!(
                        employeeId: employees_id[rand(0..(employees_id.length() - 1))],
                        buildingId: building.id,
                        batteryId:  building.batteries.ids[rand(0..(building.batteries.ids.length() - 1))],
                        interventionStartAt: Faker::Date.between(from: '2021-09-25', to: '2022-09-25'),
                        report: Faker::VulnerabilityIdentifier.cve,
                        result: Faker::ElectricalComponents.electromechanical,
                        status: status[rand(0..status.length() - 1)]
                    )
         end
     elsif state == "column"
                column_status = status[rand(0..((status.length() - 1)))]
                
               batterie =   building.batteries.all[rand(0..((building.batteries.all.length() - 1)))]  
                    if column_status == "Complete"
                        FactIntervention.create!(
                            employeeId: employees_id[rand(0..(employees_id.length() - 1))],
                            buildingId: building.id,
                            batteryId:  building.batteries.ids[rand(0..(building.batteries.ids.length() - 1))],
                            columnId:  batterie.columns.ids[rand(0..((batterie.columns.ids.length() - 1)))],
                            interventionStartAt: Faker::Date.between(from: '2021-09-25', to: '2022-09-25'),
                            interventionEndAt: Faker::Date.between(from: '2020-09-23', to: '2021-09-25'),
                            result: Faker::ElectricalComponents.electromechanical,
                            report: Faker::VulnerabilityIdentifier.cve,
                            status: "Complete"
                        )
                    else
                        status.delete("Complete")
                        FactIntervention.create!(
                         employeeId: employees_id[rand(0..(employees_id.length() - 1))],
                        buildingId: building.id,
                        batteryId:  building.batteries.ids[rand(0..(building.batteries.ids.length() - 1))],
                        columnId: batterie.columns.ids[rand(0..(batterie.columns.ids.length() -1))],
                        interventionStartAt: Faker::Date.between(from: '2021-09-25', to: '2022-09-25'),
                        report: Faker::VulnerabilityIdentifier.cve,
                        result: Faker::ElectricalComponents.electromechanical,
                        status: status[rand(0..((status.length() - 1)))]
                         )
                    end
    elsif state == "elevator"
               batterie =   building.batteries.all[rand(0..((building.batteries.all.length() - 1)))]  
               column = batterie.columns.all[rand(0..((batterie.columns.all.length() - 1)))]
              elevator_status = status[rand(0..((status.length() - 1)))]
              if elevator_status == "Complete"
                FactIntervention.create!(
                    employeeId: employees_id[rand(0..(employees_id.length() - 1))],
                    buildingId: building.id,
                    batteryId:  building.batteries.ids[rand(0..(building.batteries.ids.length() - 1))],
                    columnId:  batterie.columns.ids[rand(0..((batterie.columns.ids.length() - 1)))],
                    elevatorId: column.elevators.ids[rand(0..(column.elevators.ids.length() - 1))],
                    interventionStartAt: Faker::Date.between(from: '2021-09-25', to: '2022-09-25'),
                    interventionEndAt: Faker::Date.between(from: '2020-09-23', to: '2021-09-25'),
                    result: Faker::ElectricalComponents.electromechanical,
                    report: Faker::VulnerabilityIdentifier.cve,
                    status: "Complete"
                )
              else
                status.delete("Complete")

                FactIntervention.create!(
                    employeeId: employees_id[rand(0..(employees_id.length() - 1))],
                    buildingId: building.id,
                    batteryId:  building.batteries.ids[rand(0..(building.batteries.ids.length() - 1))],
                    columnId:  batterie.columns.ids[rand(0..((batterie.columns.ids.length() - 1)))],
                    elevatorId: column.elevators.ids[rand(0..(column.elevators.ids.length() - 1))],
                    interventionStartAt: Faker::Date.between(from: '2021-09-25', to: '2022-09-25'),
                    result: Faker::ElectricalComponents.electromechanical,
                    report: Faker::VulnerabilityIdentifier.cve,
                    status: status[rand(0..((status.length() - 1)))]

                )
              end
              puts column.elevators.ids[rand(0..(column.elevators.ids.length() - 1))]
              puts column
    end
  end  
 end   
end
   
