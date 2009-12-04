# A country where airports are located and airlines are headquartered
class Country < ActiveRecord::Base
  has_many :airports
  has_many :airlines
end
