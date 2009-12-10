require File.dirname(__FILE__) + '/../test_helper'

class TerminalTest < ActiveSupport::TestCase
 
  def test_associations_with_airport_class
    @lax = Airport.find("lax")
    assert_not_nil(@lax)
    
    @my_lax_terminal = Terminal.find(1)
    assert_not_nil(@my_lax_terminal)
    
    assert @my_lax_terminal.airport == @lax
  end
  
  def test_associations_with_user_class
    @my_lax_terminal = Terminal.find(1)
    assert_not_nil(@my_lax_terminal)

    @user = User.find(15)
    assert_not_nil(@user)
    
    assert @my_lax_terminal.user == @user
    
  end
  
end
