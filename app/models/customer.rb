require 'dropbox_api'

class Customer < ApplicationRecord
  belongs_to :user  
  belongs_to :address
  has_many :buildings

  before_update :create
  before_create :create
  
  
  def create
    lead = Lead.where(email: self.email_company_contact).first 
    
    if lead != nil 
     
      if lead.attached_file.attached?        
        
        client = DropboxApi::Client.new(ENV["DROPBOX_OAUTH_BEARER"])
        
        pathFolder = "/#{lead.full_name_contact}"
        pathcomplet = "#{pathFolder}/#{lead.attached_file.filename}"

        dropbox_folders_name = []
        dropbox_folders_list = client.list_folder ""

        dropbox_folders_list.entries.each do |entry| 
          dropbox_folders_name << entry.name 
        end 

        
        if dropbox_folders_name.include? lead.full_name_contact
          puts "Customer already has an existing dropbox folder."
          # Since the customer already has an existing dropbox folder, we only have
          # to do the upload to dropbox.
          binary = lead.attached_file.download
          client.upload(pathcomplet, binary)
          lead.attached_file.purge 
        else
          puts "Customer does not have an existing dropbox folder."

          # Since the customer does not have an existing dropbox folder, we will have
          # to create one and then upload.

          folders_name = client.create_folder(pathFolder)
          binary = lead.attached_file.download
          client.upload(pathcomplet, binary)
          lead.attached_file.purge 
        end
      end
    end              

  end 
  
end
