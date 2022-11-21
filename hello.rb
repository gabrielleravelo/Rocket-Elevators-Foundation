require 'graphql'

class QueryType < GraphQL::Schema::Object
  field :hello, String

  def hello
    "Hello world!"
  end
end

class Schema < GraphQL::Schema
  query QueryType
end

puts Schema.execute('{ hello }').to_json