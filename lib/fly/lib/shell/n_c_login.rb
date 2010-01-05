# Convenience class that hands over to CLNoColor
class NCLogin
  
  # Calls CLNoColor.setup_shell
  def self.method_missing(name, *args)
    CLNoColor.setup_shell(name)
  end
end