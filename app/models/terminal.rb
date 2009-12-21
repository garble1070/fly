class Terminal < ActiveRecord::Base
  belongs_to :airline
  belongs_to :airport, 
    :foreign_key => "airport_code", 
    :primary_key => "code"  
  
  
  # Returns the account that is ultimately responsible for this terminal.
  def owners_flc_account
    self.airline.user.my_flc_account
  end
  
  #Charges the cost of this terminal to its (new) owner.
  def charge_cost_to_owners_account
    self.owners_flc_account.debit(self.airport.terminal_cost_new)
  end
end
