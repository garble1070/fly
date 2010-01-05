#
class NCLogin
  def self.method_missing(name, *args)
    CLNoColor.start_shell(name)
  end
end