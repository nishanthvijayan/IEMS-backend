module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json
      def index
        users = RegularUser.select(:name, :id).map do |user|
          user = user.attributes
          user['guest'] = false
          user
        end

        guests = GuestUser.select(:name, :id).where('from_date <= ?', Date.current).where('to_date >= ?', Date.current)
        guests.each do |guest|
          guest = guest.attributes
          guest['guest'] = true
          users << guest
        end

        render json: {users: users.sort_by{ |user| user['name'] }}
      end
    end
  end
end
