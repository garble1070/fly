require File.dirname(__FILE__) + '/../../test_helper'

class CurrencyTest < ActiveSupport::TestCase
  
  def test_associations_with_account_class
    load_instance_vars
    
    my_currencys_accounts = @flc.accounts
    assert_kind_of(Array,my_currencys_accounts) 
    assert_equal(true,my_currencys_accounts.include?(@account_1))
    assert_equal(@account_1.currency,@flc)
  end
  
end
