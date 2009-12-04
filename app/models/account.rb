# A 'bank' account, denominated in one currency
class Account < ActiveRecord::Base
  belongs_to :user
  # TODO create methods to access currencies

  
end
