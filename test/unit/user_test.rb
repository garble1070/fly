require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase

  def test_associations_with_account_class
    @user = User.find(15)
    assert_not_nil(@user)

    @account = Account.find(1)
    assert_not_nil(@account)

    my_users_accounts = @user.accounts
    assert_kind_of(Array,my_users_accounts) 
    assert my_users_accounts.include?(@account)

    assert @account.user == @user
  end
  
  def test_associations_with_airline_class
    @user = User.find(16)
    assert_not_nil(@user)

    @airline = Airline.find(2)
    assert_not_nil(@airline)

    my_users_airlines = @user.airlines
    assert_kind_of(Array,my_users_airlines) 
    assert my_users_airlines.include?(@airline)

    assert @airline.user == @user
  end

  def test_associations_with_airport_class
    @user = User.find(15)
    assert_not_nil(@user)

    @lax = Airport.find("lax")
    assert_not_nil(@lax)

    @dfw = Airport.find("dfw")
    assert_not_nil(@dfw)

    assert @user.home_airport_real == @lax
    assert @user.home_airport_game == @dfw
    
  end

end
