#
class Login
  def self.method_missing(name, *args)
    CLWithColor.start_shell(name)
  end
end