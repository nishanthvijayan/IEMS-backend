require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  def setup
    @regular_transaction = Transaction.new(food_type: 'D', regular_user_id: 1, date: 'Wed, 7 Jun 2015', price: 50)
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
end
