# Airport that accepts passenger traffic in our system
class Airport < ActiveRecord::Base
  belongs_to :country
end
