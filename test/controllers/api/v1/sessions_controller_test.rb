require 'test_helper'

module Api
  module V1
    class SessionsControllerTest < ActionController::TestCase
      def setup
        SingleValue[:manager_password] = '12345'
      end

      test 'correct manager_password returns success response' do
        post :auth, manager_password: '12345'
        json = JSON.parse(response.body)
        assert_equal json['result'], 'Success'
      end

      test 'incorrect manager_password returns error response' do
        post :auth, manager_password: '1233546'
        json = JSON.parse(response.body)
        assert_equal json['errors'], 'Invalid password'
      end
    end
  end
end
