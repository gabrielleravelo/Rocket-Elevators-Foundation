require 'aws-sdk-core'

class AudioController < ApplicationController
    def playAudio
        # name = current_user

        # puts "------------------------------"
        # puts "before audio"
        # puts "------------------------------"

        awsAccessKey = ENV['AWSAccessKeyId']
        awsSecretKey = ENV['AWSSecretKey']
        # user = Employee.first
        master = current_user.employee
        
        nb_elevator = 0
        Elevator.all.each  do |elevator|
            nb_elevator +=1
        end

        nb_building = 0
        Building.all.each  do |building|
            nb_building +=1
        end

        nb_customer = 0
        Customer.all.each  do |customer|
            nb_customer +=1
        end

        nb_elevator_serviced = 0
        Elevator.all.each  do |elevator|
            nb_elevator +=1
            if elevator.status != "online"
                nb_elevator_serviced +=1
            end
        end

        nb_quotes = 0
        Quote.all.each  do |quote|
            nb_quotes +=1
        end

        nb_leads = 0
        Lead.all.each  do |lead|
            nb_leads +=1
        end

        nb_batteries = 0
        Battery.all.each  do |battery|
            nb_batteries +=1
        end

        # nb_diff_cities = 0
        # # Address.all.each  do |address|
        # Address.select(:city).map(&:city).uniq
        #     Address.uniq.pluck(:city) do |address|
        #     # nb_diff_cities +=1
        #     toto = nb_diff_cities
        # end
        # puts "--------------__________________-----------------"
        # puts toto

        nb_diff_cities = Address.distinct.pluck(:city).count
        #  do |address|
        #     address = nb_diff_cities
        #     puts nb_diff_cities
        # end

        Aws.config.update(
            region: 'us-east-2',
            credentials: Aws::Credentials.new(awsAccessKey, awsSecretKey)
        )
          
        client = Aws::Polly::Client.new(region: 'us-east-1')
          
        resp = client.synthesize_speech({output_format: 'mp3', text: "Greetings #{master.first_name} #{master.last_name}, dear #{master.title}. 
            There are currently #{nb_elevator} elevators deployed in the #{nb_building} buildings of your #{nb_customer} customers. 
            Currently, #{nb_elevator_serviced} elevators are not in Running Status and are being serviced. 
            You currently have #{nb_quotes} quotes awaiting processing. 
            You currently have #{nb_leads} leads in your contact requests. 
            #{nb_batteries} batteries are deployed across #{nb_diff_cities} different cities. 
            ", voice_id: 'Joey'})
        IO.copy_stream(resp.audio_stream, "briefing.mp3") 
        send_file "briefing.mp3"

   
    
    end 
end