require File.dirname(__FILE__) + '/../../test_helper'

class UserTest < ActiveSupport::TestCase
  
  def test_associations_with_account_class
    load_instance_vars
    
    my_users_accounts = @user_15.accounts
    assert_kind_of(Array,my_users_accounts) 
    assert my_users_accounts.include?(@account_1)
    
    assert_equal(@account_1.user,@user_15)
    
    assert_not_nil(@user_15.my_account)
    assert_equal(@user_15.my_account.currency_code,"FLC")
  end
  
  def test_associations_with_airline_class
    load_instance_vars
    
    my_users_airlines = @user_16.airlines
    assert_kind_of(Array,my_users_airlines) 
    assert_equal(true,my_users_airlines.include?(@airline_2))
    
    assert_equal(@airline_2.user,@user_16)
    assert_equal(@user_16.my_airline,@airline_2)
  end
  
  def test_associations_with_airport_class
    load_instance_vars
    
    assert_equal(@user_15.home_airport_real,@lax)
    
    f_ops_airports = @user_15.friends_ops_airports
    assert_not_nil(f_ops_airports)
    assert_kind_of(Array, f_ops_airports)
    assert f_ops_airports.include?(@lax)
    assert f_ops_airports.include?(@jfk)
    assert_equal(f_ops_airports.include?(@dfw),false)
    
    excl_airports = @user_15.ops_airports_exclusive_to_friends
    assert_not_nil(excl_airports)
    assert_kind_of(Array, excl_airports)
    assert_equal(excl_airports.include?(@lax),false)
    assert excl_airports.include?(@jfk)
    assert_equal(f_ops_airports.include?(@dfw),false)

  end
  
  def test_associations_with_terminal_class
    load_instance_vars
        
    my_terminals = @user_15.terminals
    assert_kind_of(Array,my_terminals) 
    assert my_terminals.include?(@terminal_1)
    assert my_terminals.include?(@terminal_2)
    assert my_terminals.include?(@terminal_3)
    
  end
  
  def test_associations_with_flight_class
    load_instance_vars

    my_flights = @user_17.flights
    my_planes = @user_17.planes
    calculated_flights = my_planes.collect do |plane|
      plane.flights
    end
    calculated_flights.flatten!
    
    assert my_flights.include?(@flight_222)
    assert calculated_flights.include?(@flight_222)

    my_flights_sorted = my_flights.sort {|x,y| y.id <=> x.id }
    calculated_flights_sorted = calculated_flights.sort {|x,y| y.id <=> x.id }
    assert_equal(calculated_flights_sorted,my_flights_sorted)
  end
  
end
