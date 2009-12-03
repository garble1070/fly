# A 'bank' account, denominated in one currency
class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :currency
  
end
