class FlyError
  #  Raise an error if this method is called.
  def raise_superclass_error
    raise RuntimeError.new("This method is meant to be called in the subclass.")
  end
end
