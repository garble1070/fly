require File.dirname(__FILE__) + '/../../test_helper'

class TerminalTest < ActiveSupport::TestCase
 
  def load_instance_vars
    @lax = Airport.find("LAX")    
    @jfk = Airport.find("jfk")
    @airline_1 = Airline.find(1)
    @airline_2 = Airline.find(2)
    @terminal_1 = Terminal.find(1)
    @terminal_6 = Terminal.find(6)
  end

  def test_associations_with_airport_class
    load_instance_vars
    assert_not_nil(@lax)
    assert_not_nil(@terminal_1)
    
    assert @terminal_1.airport == @lax
  end
  
  def test_associations_with_user_class
    load_instance_vars
    assert_not_nil(@terminal_6)
    assert_not_nil(@airline_2)
    
    assert @terminal_6.airline == @airline_2
  end
  
  def test_airline_stuff
    load_instance_vars
#    owners_flc_account
#    charge_cost_to_owners_account
  end
  
end
