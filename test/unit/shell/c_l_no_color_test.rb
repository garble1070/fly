require File.dirname(__FILE__) + '/../../test_helper'

class CLNoColorTest < ActiveSupport::TestCase
 
  def test_say_error
    output = capture_stdout do 
      CLNoColor.say_error("Hello World!")
    end
    assert_equal("\nERROR: Hello World!\n", output)
  end


end
