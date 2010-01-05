#
class Login
  def self.method_missing(name, *args)
    CL.send(name,*args)
  end
end