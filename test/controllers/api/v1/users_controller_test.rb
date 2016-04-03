require 'test_helper'

module Api
  module V1
    class UsersControllerTest < ActionController::TestCase
      test 'lists all users' do
        get :index, format: :json
        json = JSON.parse(response.body)['users']

        assert_response :success

        assert_equal json.length, 6
        assert_equal json[0].keys, %w(id name guest)
      end
    end
  end
end
