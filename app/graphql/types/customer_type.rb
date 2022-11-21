# frozen_string_literal: true

module Types
  class CustomerType < Types::BaseObject
    field :id, ID, null: false
    field :customers_creation_date, String
    field :company_name, String
    field :Company_headquarters_address, String
    field :fullname_company_contact, String
    field :company_contact_phone, String
    field :email_company_contact, String
    field :Company_description, String
    field :fullname_service_technical_authority, String
    field :technical_authority_phone_service, String
    field :technical_manager, String
    field :_email_service, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user_id, Integer
    field :address_id, Integer
  end
end
