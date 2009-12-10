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
    
    @iad = Airport.find("iad")
    assert_not_nil(@iad)
    
    @dfw = Airport.find("dfw")
    assert_not_nil(@dfw)
    
    assert @user.home_airport_real == @lax
    assert @user.home_airport_game == @dfw
    
    my_airports = @user.airport_terminal_locations
    assert_kind_of(Array,my_airports) 
    assert my_airports.include?(@lax)
    assert my_airports.include?(@iad)
    assert my_airports.include?(@dfw)
  end
  
  def test_associations_with_terminal_class
    @user = User.find(15)
    assert_not_nil(@user)
    
    @my_terminal_at_lax = Terminal.find(1)
    assert_not_nil(@my_terminal_at_lax)
    
    @my_terminal_at_iad = Terminal.find(2)
    assert_not_nil(@my_terminal_at_iad)
    
    @my_terminal_at_dfw = Terminal.find(3)
    assert_not_nil(@my_terminal_at_dfw)
    
    my_terminals = @user.terminals
    assert_kind_of(Array,my_terminals) 
    assert my_terminals.include?(@my_terminal_at_lax)
    assert my_terminals.include?(@my_terminal_at_iad)
    assert my_terminals.include?(@my_terminal_at_dfw)
    
  end
  
end
