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
  
  # Add more helper methods to be used by all tests here...
  def load_instance_vars
    @to_load = []
    load_country_vars
    load_aircrafttype_vars
    load_terminal_vars
    load_user_vars
    load_airline_vars
    load_currency_vars
    load_airport_vars
    load_flight_vars
    load_account_vars
    load_plane_vars
    execute_loading
  end
  
  def load_country_vars
    @us = Country.find("US")
    assert_not_nil(@us)
    @ch = Country.find("CH")    
    assert_not_nil(@ch)
  end
  
  def load_aircrafttype_vars
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
  end
  
  def load_terminal_vars
    @terminal_1 = Terminal.find(1)
    assert_not_nil(@terminal_1)
    @terminal_2 = Terminal.find(2)
    assert_not_nil(@terminal_2)
    @terminal_3 = Terminal.find(3)
    assert_not_nil(@terminal_3)
    @terminal_6 = Terminal.find(6)
    assert_not_nil(@terminal_6)
  end
  
  def load_user_vars
    @user_15 = User.find(15)
    assert_not_nil(@user_15)
    @user_16 = User.find(16)
    assert_not_nil(@user_16)
    @user_17 = User.find(17)        
    assert_not_nil(@user_17)
  end
  
  def load_currency_vars
    @flc = Currency.find("FLC")
    assert_not_nil(@flc)
  end
  
  def load_airport_vars
    @lax = Airport.find("LAX")
    assert_not_nil(@lax)
    @zrh = Airport.find("ZRH")
    assert_not_nil(@zrh)
    @sfo = Airport.find("SFO")
    assert_not_nil(@sfo)
    @iad = Airport.find("IAD")
    assert_not_nil(@iad)
    @dfw = Airport.find("DFW")
    assert_not_nil(@dfw)
    @jfk = Airport.find("JFK")
    assert_not_nil(@jfk)
    @dep_airport_lax = DepartureAirport.find("LAX")
    assert_not_nil(@dep_airport_lax)
    @arr_airport_zrh = ArrivalAirport.find("ZRH")
    assert_not_nil(@arr_airport_zrh)
  end
  
  def load_airline_vars
    @airline_1 = Airline.find(1)
    assert_not_nil(@airline_1)
    @airline_2 = Airline.find(2)
    assert_not_nil(@airline_2)
    @airline_3 = Airline.find(3)
    assert_not_nil(@airline_3)
  end
  
  def load_flight_vars
    @flight_220 = Flight.find(220)
    assert_not_nil(@flight_220)
    @flight_221 = Flight.find(221)
    assert_not_nil(@flight_221)
    @flight_222 = Flight.find(222)
    assert_not_nil(@flight_222)
  end
  
  def load_account_vars
    @account_1 = Account.find(1)
    assert_not_nil(@account_1)
  end
  
  def load_plane_vars
    @plane_1 = Plane.find(1)
    assert_not_nil(@plane_1)
    @plane_2 = Plane.find(2)
    assert_not_nil(@plane_2)
  end
end
