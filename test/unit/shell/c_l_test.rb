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

  def test_launch_main_menu_routine
    assert_raise(RuntimeError) { CL.launch_main_menu_routine(nil) }
  end
  
  def test_instance_method_missing
    load_instance_vars
    output = capture_stdout do 
      CL.new(@user_15).say_notice("Hello World!")
    end
    assert_equal("\nHello World!\n", output)
  end
end
