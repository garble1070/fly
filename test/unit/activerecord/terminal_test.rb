require File.dirname(__FILE__) + '/../../test_helper'

class TerminalTest < ActiveSupport::TestCase
 
  def test_associations_with_airport_class
    load_instance_vars
    
    assert @terminal_1.airport == @lax
  end
  
  def test_associations_with_user_class
    load_instance_vars
    
    assert @terminal_6.airline == @airline_2
  end
  
  def test_airline_stuff
    load_instance_vars
#    owners_flc_account
#    charge_cost_to_owners_account
  end
  
end
