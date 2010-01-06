# Convenience class that hands over to CLNoColor
class Login
  
  # Instantiates a new CLNoColor object
  def self.method_missing(name, *args)
    CLWithColor.new(name)
  end
end