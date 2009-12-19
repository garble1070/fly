$:.unshift "#{File.dirname(__FILE__)}/lib/builders"
  require "creator" #superclass
  require "flight_creator"
  require "plane_creator"
  
$:.unshift "#{File.dirname(__FILE__)}/lib/mapping"
  require "static_map" #superclass
  require "airport_map"
  require "flight_map"
  require "map_marker"
  require "map_path"
  
$:.unshift "#{File.dirname(__FILE__)}/lib/routing"
  require "flight_plan"
  require "flight_segment"
  require "segment_series"

$:.unshift "#{File.dirname(__FILE__)}/lib/other"
  require "query_collection" #superclass
  require "query_collection_exclusive_key"
  require "query_collection_non_exclusive_key"
  require "query_param"
  require "fly_error"

$:.unshift "#{File.dirname(__FILE__)}/lib/quantities"
  require "quantity" #superclass
  require "distance_in_miles"
  require "duration_in_seconds"
  require "number_of_passengers"
  require "starting_miles_count"
  require "starting_pax_count"