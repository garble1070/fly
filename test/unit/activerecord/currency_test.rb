require File.dirname(__FILE__) + '/../../test_helper'

class CurrencyTest < ActiveSupport::TestCase
  
  def load_instance_vars
    @flc = Currency.find("FLC")
    @account_1 = Account.find(1)
  end
  
  def test_associations_with_account_class
    load_instance_vars
    assert_not_nil(@flc)
    assert_not_nil(@account_1)
    
    my_currencys_accounts = @flc.accounts
    assert_kind_of(Array,my_currencys_accounts) 
    assert_equal(true,my_currencys_accounts.include?(@account_1))
    assert_equal(@account_1.currency,@flc)
  end
  
end
