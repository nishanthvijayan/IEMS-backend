module Api
  module V1
    class SessionsController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def auth
        if SingleValue[:manager_password] == params[:manager_password]
          render json: { result: 'Success' }, status: 200
        else
          render json: { errors: 'Invalid password' }, status: 422
        end
      end
    end
  end
end
