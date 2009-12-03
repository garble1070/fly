require '../test_helper'

class CurrencyTest < ActiveSupport::TestCase
  # Replace this with your real tests.


  def test_associations
    @currency = Currency.find("FLC")
    @account = Account.find(1)
    assert_not_nil(@currency)
    assert_not_nil(@account)
    my_currencys_accounts = @currency.accounts
    assert_kind_of(Array,my_currencys_accounts) 
    assert my_currencys_accounts.include?(@account)
  end

end
