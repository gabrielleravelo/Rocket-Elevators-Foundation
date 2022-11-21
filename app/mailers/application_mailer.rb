class ApplicationMailer < ActionMailer::Base
  default from: ENV['SENDGRID_MAIL']
  layout 'mailer'
 
end
