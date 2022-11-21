require 'json'
require 'sendgrid-ruby'

class LeadNotifierMailer < ApplicationMailer
    layout 'mailer'
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_contactus_email(lead)
    
    @lead = lead
    attachments.inline['R2.png'] = File.read('app/assets/images/R2.png')
    mail( :to => @lead.email,
    :subject => 'Thanks for contact us' )
  end

end
