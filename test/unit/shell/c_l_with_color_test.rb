require File.dirname(__FILE__) + '/../../test_helper'

class CLWithColorTest < ActiveSupport::TestCase
 
  def test_say_error
      CLWithColor.set_up_color_scheme
    output = capture_stdout do 
      CLWithColor.say_error("Hello World!")
    end
    assert_equal("\n\e[1m\e[31mHello World!\e[0m\n", output)
  end

  def test_say_notice
      CLWithColor.set_up_color_scheme
    output = capture_stdout do 
      CLWithColor.say_notice("Hello World!")
    end
    assert_equal("\n\e[1m\e[32mHello World!\e[0m\n", output)
  end

end
