require File.dirname(__FILE__) + '/../../test_helper'

class TerminalTest < ActiveSupport::TestCase
 
  def test_associations_with_airport_class
    @lax = Airport.find("lax")
    assert_not_nil(@lax)
    
    @my_lax_terminal = Terminal.find(1)
    assert_not_nil(@my_lax_terminal)
    
    assert @my_lax_terminal.airport == @lax
  end
  
  def test_associations_with_user_class
    @my_jfk_terminal = Terminal.find(6)
    assert_not_nil(@my_jfk_terminal)

    @my_airline = Airline.find(2)
    assert_not_nil(@my_airline)
    
    assert @my_jfk_terminal.airline == @my_airline
    
  end
  
end
