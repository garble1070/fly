# A currency, i.e. FLC (Fly Credits) or USD
class Currency < ActiveRecord::Base
  has_many :accounts, 
      :foreign_key => "currency_code", 
      :primary_key => "code"
  
  named_scope :code_is , lambda{|code| { :conditions => {:code => code}
    }}
  
  
end
