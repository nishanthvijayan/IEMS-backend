require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  def setup
    @client = Client.new(name: 'testclient', password: '123456789')
  end

  test 'should be valid' do
    assert @client.valid?
  end

  test 'name should not be blank' do
    @client.name = '    '
    assert_not @client.valid?
  end

  test 'password should be atleast 8 characters long' do
    @client.password = 'abc'
    assert_not @client.valid?
  end

  test 'sets auth_token on create' do
    @client.save
    assert_not @client.auth_token.blank?
  end
end
