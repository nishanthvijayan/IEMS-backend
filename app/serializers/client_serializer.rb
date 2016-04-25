class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :auth_token
end
