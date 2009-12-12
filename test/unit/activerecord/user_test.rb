require File.dirname(__FILE__) + '/../../test_helper'

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
    
    @jfk = Airport.find("jfk")
    assert_not_nil(@jfk)
    
    @dfw = Airport.find("dfw")
    assert_not_nil(@dfw)
    
    assert @user.home_airport_real == @lax
    
    f_ops_airports = @user.friends_ops_airports
    assert_not_nil(f_ops_airports)
    assert_kind_of(Array, f_ops_airports)
    assert f_ops_airports.include?(@lax)
    assert f_ops_airports.include?(@jfk)
    assert f_ops_airports.include?(@dfw) == false
    
    excl_airports = @user.ops_airports_exclusive_to_friends
    assert_not_nil(excl_airports)
    assert_kind_of(Array, excl_airports)
    assert excl_airports.include?(@lax) == false
    assert excl_airports.include?(@jfk)
    assert f_ops_airports.include?(@dfw) == false

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
  
  def test_associations_with_flight_class
    @user = User.find(17)
    assert_not_nil(@user)

    my_flights = @user.flights
    my_planes = @user.planes
    calculated_flights = my_planes.collect do |plane|
      plane.flights
    end
    calculated_flights.flatten!
    
    @flight = Flight.find(222)
    assert my_flights.include?(@flight)
    assert calculated_flights.include?(@flight)

    my_flights_sorted = my_flights.sort {|x,y| y.id <=> x.id }
    calculated_flights_sorted = calculated_flights.sort {|x,y| y.id <=> x.id }
    assert calculated_flights_sorted == my_flights_sorted
  end
  
end
