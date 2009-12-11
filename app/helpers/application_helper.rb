# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Returns the controller object       
  attr_reader :controller
  # Returns the Activerecord instance object
  
  attr_reader :instance
  
  # Returns an integer representing the record ID if one is specified in the URL
  attr_reader :id
  
end
