require File.dirname(__FILE__) + '/../../test_helper'

class TerminalTest < ActiveSupport::TestCase
  
  def test_associations_with_airport_class
    load_instance_vars
    
    assert_equal(@lax,@terminal_1.airport)
  end
  
  def test_associations_with_user_class
    load_instance_vars
    
    assert_equal(@airline_2,@terminal_6.airline)
  end
  
  def test_owners_flc_account
    load_instance_vars
    
    assert_equal(@account_1,@terminal_1.owners_flc_account)
  end
  
  def test_charge_cost_to_owners_account
    load_instance_vars
    
    assert_equal(300.50,@account_1.balance)
    @terminal_1.charge_cost_to_owners_account
    load_instance_vars
    assert_equal(200.50,@account_1.balance)
  end
  
end
