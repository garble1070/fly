# A 'bank' account, denominated in one currency
class Account < ActiveRecord::Base
  belongs_to :user
  
  named_scope :currency_is, lambda { |currency_code|
    {:conditions => { "currency_code" => currency_code}}}
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns this account's currency object
  def currency_obj
    Currency.get(self.currency_code)
  end

  # Alias for 'currency_obj', to match rails convention
  def currency
    self.currency_obj
  end
  
  # Returns this account's user object
  def user_obj
    self.user
  end
  
  
end
