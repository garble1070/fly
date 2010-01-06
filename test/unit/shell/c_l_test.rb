require File.dirname(__FILE__) + '/../../test_helper'

class CLTest < ActiveSupport::TestCase
 
  def test_say_error
    output = capture_stdout do 
      CL.say_error("Hello World!")
    end
    assert_equal("\nHello World!\n", output)
  end

  def test_say_notice
    output = capture_stdout do 
      CL.say_notice("Hello World!")
    end
    assert_equal("\nHello World!\n", output)
  end

end
