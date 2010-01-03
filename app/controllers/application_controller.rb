# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  include Geokit::Mappable 
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  require "erector"
  require "erector_widget_extensions"
  require "fly/init"
  
  def method_missing(name, *args)
    if methods.include?(name.to_s)
      super(name,*args)
    else
      look_for_item(name, *args)
    end
  end
  
  def look_for_item(name,*args)
    case name.to_s.length
      when 2 then look_for_airline_short_code(name, *args)
      when 6 then look_for_flight_identifier(name, *args)
    end
  end
  
  def look_for_airline_short_code(name, *args)
    results = Airline.short_code_is(name.to_s)
    if results.length > 0
      results[0]
    end
  end
  
  def look_for_flight_identifier(name, *args)
    results = Flight.flight_identifier_is(name.to_s)
    if results.length > 0
      results[0]
    end
  end
  
end
