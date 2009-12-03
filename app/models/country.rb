# Country where airports are located
class Country < ActiveRecord::Base
  has_many :airports
  has_many :airlines
end
