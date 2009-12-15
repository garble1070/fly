# Extends Float class to include the 'to_s_rnd' method
class Float
  
  # Rounds a floating point number to 3 digits and returns it as a string
  def to_s_rnd
    self.round(3).to_s
  end
end

# Extends Geokit::LatLng class to include the 'to_s_rnd' method
class Geokit::LatLng
  
  def to_s_rnd
    @lat.to_s_rnd + "," + @lng.to_s_rnd
  end
end