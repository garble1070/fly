# Convenience class that hands over to CLNoColor
class NCLogin
  
  # Instantiates a new CLNoColor object
  def self.method_missing(name, *args)
    CLNoColor.new(name)
  end
end