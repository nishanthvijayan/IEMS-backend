module Api
  module V1
    class SessionsController < ApplicationController
      def create
        client_password = params[:manager_password]
        client_name = params[:client_id]
        client = client_name.present? && Client.find_by_name(client_name)

        if client && client.authenticate(client_password)
          render json: client, status: 200
        else
          render json: { errors: 'Invalid client_id or password' }, status: 422
        end
      end
    end
  end
end
