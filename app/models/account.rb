# A 'bank' account, denominated in one currency
class Account < ActiveRecord::Base
  belongs_to :user
  
  named_scope :currency_is, lambda { |currency_code|
    {:conditions => { "currency_code" => currency_code}}}
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns this account's currency object
  def currency
    Currency.find(self.currency_code)
  end

  
end
