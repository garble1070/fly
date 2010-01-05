# Convenience class that hands over to CLNoColor
class Login
  
  # Calls CLNoColor.setup_shell
  def self.method_missing(name, *args)
    CLWithColor.setup_shell(name)
  end
end