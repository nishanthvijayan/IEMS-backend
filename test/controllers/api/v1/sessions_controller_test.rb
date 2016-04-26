require 'test_helper'

module Api
  module V1
    class SessionsControllerTest < ActionController::TestCase
      def setup
        @client = Client.create(name: 'testclient', password: '123456789')
      end

      test 'valid client details returns client details' do
        post :create, client_id: 'testclient', manager_password: '123456789'
        json = JSON.parse(response.body)
        assert_equal json['client'].keys, %w(id name auth_token)
        assert_equal json['client']['name'], 'testclient'
      end

      test 'invalid client details does not returns client details' do
        post :create, client_id: 'testclient', manager_password: 'abcdefghijlkm'
        json = JSON.parse(response.body)
        assert_equal json['errors'], 'Invalid client_id or password'
      end
    end
  end
end
