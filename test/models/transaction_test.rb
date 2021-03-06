require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  def setup
    @regular_transaction = Transaction.new(food_type: 'D', regular_user_id: 1, date: 'Wed, 7 Jun 2015', price: 50)
    @guest_user = guest_users(:guest_one)
  end

  test 'should be valid' do
    assert @regular_transaction.valid?
  end

  test 'should respond to regular_user' do
    assert_respond_to @regular_transaction, :regular_user
  end

  test 'food_type should not be blank' do
    @regular_transaction.food_type = '    '
    assert_not @regular_transaction.valid?
  end

  test 'date should not be blank' do
    @regular_transaction.date = '    '
    assert_not @regular_transaction.valid?
  end

  test 'price should not be blank/nil' do
    @regular_transaction.price = nil
    assert_not @regular_transaction.valid?
  end

  test 'regular_user_id should not be blank for regular transaction' do
    @regular_transaction.regular_user_id = nil
    assert_not @regular_transaction.valid?
  end

  test 'guest_user_id should not be blank for guest transaction' do
    @regular_transaction.guest_transaction = true
    assert_not @regular_transaction.valid?
  end

  test 'responds to set_billed_user' do
    assert_respond_to @regular_transaction, :set_billed_user
  end

  test 'sets correct regular_user if guest_transaction' do
    @regular_transaction.guest_transaction = true
    @regular_transaction.regular_user = nil
    @regular_transaction.guest_user = @guest_user
    @regular_transaction.save
    assert_not @regular_transaction.regular_user_id.nil?
  end
end
