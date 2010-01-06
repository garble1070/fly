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
  
=begin
  def test_launch_main_menu_routine
    assert_raise(RuntimeError) { CL.launch_main_menu_routine(nil) }
  end
=end

=begin
  def test_instance_method_missing
    load_instance_vars
    output = capture_stdout do 
      CL.new(@user_15).say_notice("Hello World!")
    end
    assert_equal("\nHello World!\n", output)
  end
=end
  
  def test_class_method_missing
    output = capture_stdout do 
      @response = CL.aa
    end
    assert_equal("\nSorry, that username is not valid.\n", output)
    assert_equal(:try_again,@response)
  end
end
