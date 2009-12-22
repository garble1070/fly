require File.dirname(__FILE__) + '/../../test_helper'

class AccountTest < ActiveSupport::TestCase
    
  def test_transaction_stuff
    load_instance_vars
    assert_equal(300.50,@account_1.balance)
    assert_equal(true,@account_1.debit(100))
    
    load_instance_vars
    assert_equal(200.50,@account_1.balance)
    
    assert_equal(false,@account_1.debit(400))
    assert_equal(200.50,@account_1.balance)
    
    assert_equal(true,@account_1.credit(100))
    assert_equal(300.50,@account_1.balance)
    
    @new_account = Account.new
    assert_equal(false,@new_account.record_transaction)
  end
  
end
