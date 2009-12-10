# A 'bank' account, denominated in one currency
class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :currency, :foreign_key => "currency_code"
  
  named_scope :currency_is, lambda { |currency_code|
    {:conditions => { "currency_code" => currency_code}}}
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  
end
