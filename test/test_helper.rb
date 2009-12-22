ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true
  
  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false
  
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  
  # Calls all loader methods, and assigns all specified instance variables
  def load_instance_vars
    @to_load = []
    loader_method_names.each do |string|
      send("load_#{string}_vars")
    end
    assign_vars
#    check_vars
  end
  
  # Returns an array of loader method names that will be called
  def loader_method_names
    ["country","aircrafttype","terminal","user","airline","currency",
        "airport","flight","account","plane","quantity"]  
  end
  
  # Sets each instance variable, as specified in the "@to_load" array
  def assign_vars
    @to_load.each do |hash|
      instance_variable_set(hash[:name],hash[:obj])
    end
  end
  
  # Checks that each instance variable is not nil
  def check_vars
    @to_load.each do |hash|
      assert_not_nil(instance_variable_get(hash[:name]))
    end
  end
  
  # Adds a name and an object to the array of instance variables that will be set
  def vars_add(name,obj)
    @to_load << {:name => name, :obj => obj}  
  end
  
  def load_country_vars
    vars_add("@us",Country.find("US"))
    vars_add("@ch",Country.find("CH"))    
  end
  
  def load_aircrafttype_vars
    vars_add("@a330",Aircrafttype.find(1))
    vars_add("@b747",Aircrafttype.find(2))
  end
  
  def load_terminal_vars
    vars_add("@terminal_1",Terminal.find(1))
    vars_add("@terminal_2",Terminal.find(2))
    vars_add("@terminal_3",Terminal.find(3))
    vars_add("@terminal_6",Terminal.find(6))
  end
  
  def load_user_vars
    vars_add("@user_15",User.find(15))
    vars_add("@user_16",User.find(16))
    vars_add("@user_17",User.find(17))
  end
  
  def load_currency_vars
    vars_add("@flc",Currency.find("FLC"))
  end
  
  def load_airport_vars
    vars_add("@lax",Airport.find("LAX"))
    vars_add("@zrh",Airport.find("ZRH"))
    vars_add("@sfo",Airport.find("SFO"))
    vars_add("@iad",Airport.find("IAD"))
    vars_add("@dfw",Airport.find("DFW"))
    vars_add("@jfk",Airport.find("JFK"))
    vars_add("@cdg",Airport.find("CDG"))
    vars_add("@dep_airport_lax",DepartureAirport.find("LAX"))
    vars_add("@arr_airport_zrh",ArrivalAirport.find("ZRH"))
    vars_add("@arr_airport_iad",ArrivalAirport.find("IAD"))
  end
  
  def load_airline_vars
    vars_add("@airline_1",Airline.find(1))
    vars_add("@airline_2",Airline.find(2))
    vars_add("@airline_3",Airline.find(3))
  end
  
  def load_flight_vars
    vars_add("@flight_220",Flight.find(220))
    vars_add("@flight_221",Flight.find(221))
    vars_add("@flight_222",Flight.find(222))
  end
  
  def load_account_vars
    vars_add("@account_1",Account.find(1))
  end
  
  def load_plane_vars
    vars_add("@plane_1",Plane.find(1))
    vars_add("@plane_2",Plane.find(2))
  end
  
  def load_quantity_vars
    vars_add("@sixty_thousand_pax",StartingPaxCount.new(60000))
    vars_add("@one_hundred_k_miles",StartingMilesCount.new(100000))
  end
end
