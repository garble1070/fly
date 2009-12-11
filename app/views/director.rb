# This is the primary 'view controller', in other words the central switching point from which all
# markup generation is initiated
class Views::Director
  
  
 
  # Assigns the necessary instance variables for this class
  def initialize (helper_template)
    @helper_template = helper_template
  end
    
  # Instantiates the appropriate 'wrapper' widget (html, pdf, or js)
  def get_started
    html = Views::MainHtmlWrapper.new(:helper_template => @helper_template).to_pretty
  end
  
end