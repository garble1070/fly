# A currency, i.e. FLC (Fly Credits) or USD
class Currency < ActiveRecord::Base
  has_many :accounts
end
