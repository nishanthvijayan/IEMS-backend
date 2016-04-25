require 'test_helper'

module Api
  module V1
    class TransactionControllerTest < ActionController::TestCase
      def setup
        @client = Client.create(name: 'testclient', password: '123456789')
      end

      test 'saves new transaction on submitting valid data' do
        assert_difference 'Transaction.count', 1 do
          post :create, transaction: {guest_transaction: false, regular_user_id: 1, food_type: 'D', price: 100, date: '29/3/2016'}, access_token: @client.auth_token
        end
        json = JSON.parse(response.body)
        assert_equal json.keys, %w(id guest_user_id regular_user_id guest_transaction food_type date price image created_at updated_at)
      end

      test 'displays error and does not save new transaction on submitting invalid/incomplete data' do
        assert_no_difference 'Transaction.count' do
          post :create, transaction: {guest_transaction: false, regular_user_id: 1, food_type: 'D', date: '29/3/2016'}, access_token: @client.auth_token
          json = JSON.parse(response.body)
          assert_equal json.keys, ['status', 'message'], json.inspect
        end
      end
    end
  end
end
