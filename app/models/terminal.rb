class Terminal < ActiveRecord::Base
  belongs_to :airline
  belongs_to :airport, 
    :foreign_key => "airport_code", 
    :primary_key => "code"  
  
  
  # Returns the account that is ultimately responsible for this terminal.
  def my_account
    self.airline.user.my_account
  end
  
  #Charges the cost of this terminal to its (new) owner.
  def charge_cost_to_my_account
    self.my_account.debit(self.airport.terminal_cost_new)
  end
end
