require File.dirname(__FILE__) + '/../../test_helper'

class AccountTest < ActiveSupport::TestCase

 def test_transaction_stuff
   @account = Account.find(1)
   assert_equal(300.50,@account.balance)
   
   assert_equal(true,@account.debit(100))

   @account = Account.find(1)
   assert_equal(200.50,@account.balance)
   
   assert_equal(false,@account.debit(400))
   assert_equal(200.50,@account.balance)

   assert_equal(true,@account.credit(100))
   assert_equal(300.50,@account.balance)
   
   
 end

end
