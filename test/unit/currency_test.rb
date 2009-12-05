require File.dirname(__FILE__) + '/../test_helper'

class CurrencyTest < ActiveSupport::TestCase

  def test_associations_with_account_class
    @currency = Currency.get("FLC")
    assert_not_nil(@currency)

    @account = Account.find(1)
    assert_not_nil(@account)

    my_currencys_accounts = @currency.accounts
    assert_kind_of(Array,my_currencys_accounts) 
    assert my_currencys_accounts.include?(@account)

    assert @account.currency_obj == @currency
    assert @account.currency == @currency
  end

end
