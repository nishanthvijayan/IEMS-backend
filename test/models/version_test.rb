require 'test_helper'

class VersionTest < ActiveSupport::TestCase
  test 'tracks RegularUser' do
    assert_difference 'Version.count', 1 do
      RegularUser.create(name: 'Example user', email: 'example@gmail.com', password: 'somepassword', password_confirmation: 'somepassword')
    end
  end

  test 'tracks GuestUser' do
    assert_difference 'Version.count', 1 do
      GuestUser.create(name: 'ExampleUser', regular_user_id:  1, from_date: '1995/8/28', to_date: '1995/8/23')
    end
  end

  test 'tracks Transaction' do
    assert_difference 'Version.count', 1 do
      Transaction.create(food_type: 'D', regular_user_id: 1, date: 'Wed, 7 Jun 2015', price: 50)
    end
  end
end
