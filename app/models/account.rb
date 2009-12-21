# A 'bank' account, denominated in one currency
class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :currency, :foreign_key => "currency_code" 
  
  named_scope :currency_is , lambda{|currency_code| { :conditions => {:currency_code => currency_code}
    }}
  
   validates_presence_of     :currency_code

  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  def debit(amount)
    if balance_adequate_for_transaction?(amount)
      self.balance = balance - amount
      record_transaction
    else
      return false
    end
  end
   
  def credit(amount)
    self.balance = balance + amount
    record_transaction
  end
  
  def balance_adequate_for_transaction?(amount)
    if self.balance > amount
      return true
    else
      return false
    end
  end
  
  def record_transaction
    if self.save
      return true
    else
      return false
    end   
  end
  
end
