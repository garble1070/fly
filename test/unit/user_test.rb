require '../test_helper'

class UserTest < ActiveSupport::TestCase

  def test_associations
    @user = User.find(15)
    @account = Account.find(1)
    assert_not_nil(@user)
    assert_not_nil(@account)
    my_users_accounts = @user.accounts
    assert_kind_of(Array,my_users_accounts) 
    assert my_users_accounts.include?(@account)
    
    @user1 = User.find(16)
    @airline = Airline.find(2)
    assert_not_nil(@user1)
    assert_not_nil(@airline)
    my_users_airlines = @user1.airlines
    assert_kind_of(Array,my_users_airlines) 
    assert my_users_airlines.include?(@airline)
  end

end
