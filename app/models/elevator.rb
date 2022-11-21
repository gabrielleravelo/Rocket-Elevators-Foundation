require 'slack-ruby-client'

require 'twilio-ruby'

class Elevator < ApplicationRecord
    belongs_to :column 

    before_update :beforesms
    after_update :sms

    def beforesms
        @oldstatus = status_was
    end
    
    def sms
        if status != @oldstatus && status.downcase == "intervention" 
            account_sid = ENV['twilio_account_sid']
            auth_token = ENV['twilio_auth_token']
            client = Twilio::REST::Client.new(account_sid, auth_token)
    
            from = ENV['twilio_phone_number'] # Your Twilio number
            to = '' # Your mobile phone number
    
            client.messages.create(
            from: from,
            to: to,
            body: 'Hi Mr. Tech, the status of the elevator #' + id.to_s + ' has changed from "' + @oldstatus + '" to "' + status + '"! Can you please fix this?'
            )
        end 
    end



    # display message after change
    before_update :beforestatuschange
    after_update :afterstatuschange
    
    def beforestatuschange
        @oldstatus = status_was    
    end
        

    def afterstatuschange
        client = Slack::Web::Client.new
        client.auth_test
        if status != @oldstatus
            client.chat_postMessage(channel: '#elevator_operations', text: "The Elevator #{id} with Serial Number #{serial_number} changed status from #{@oldstatus} to #{status}", as_user: true)
        end
    end
end