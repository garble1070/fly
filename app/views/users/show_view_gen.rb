class Views::Users::ShowViewGen < Erector::Widget
  needs :helper_template => true
  
  # Establishes the necessary instance variables for this widget
  def prep_variables
    @instance = @helper_template.instance
    @my_airline = @instance.my_airline
    @home_airport_real = @instance.home_airport_real
    @home_airport_game = @my_airline.home_airport_game
    if @helper_template.params[:from]
      @dep_airport = @helper_template.params[:from]
    end
    if @helper_template.params[:to]
      @arr_airport = @helper_template.params[:to]
    end
    @distance = unless @helper_template.params[:dist] && (@helper_template.params[:dist].to_i > 0)
      0
    else
      @helper_template.params[:dist].to_i
    end
  end
  
  # Generates this widget's markup output
  def content
    prep_variables
    set_parameters
    p_blankline_hr
    #    rawtext @helper_template.javascript_tag("alert(window.location.host)")
    emit_airport_map
    if @dep_airport && @arr_airport
      emit_flight_map
    end
    emit_field_data
    3.times do p_blankline end
  end
  
  def emit_airport_map
    airline = @instance.my_airline
    map = AirportMap.new(airline)
    href = "http://maps.google.com/maps/api/staticmap" + map.complete_url
    img :src => href, :width => "450", :height => "300"
  end
  
  def emit_flight_map
    dep_airport = Airport.find(@helper_template.params[:from])
    arr_airport = Airport.find(@helper_template.params[:to])
    map = FlightMap.new(dep_airport,arr_airport)
    href = "http://maps.google.com/maps/api/staticmap" + map.complete_url(@distance)
    img :src => href, :width => "450", :height => "300"
  end
  
  def list
    [{:label => "Name", 
       :text => @instance.first_name + " " + @instance.last_name},
    {:label => "Email", 
       :text => @instance.email},
    {:label => "Airport nearest to your home (in real life)", 
       :text => "#{@home_airport_real.display_name} (#{@home_airport_real.code})"},
    {:label => "Where your airline is based (in the game)", 
       :text => "#{@home_airport_game.display_name} (#{@home_airport_game.code})"},
    {:label => "Your airline's country of registration", 
       :text => @my_airline.country.display_name},
    {:label => "Your airline's satisfaction rating", 
       :text => @my_airline.satisfaction_rating},
    {:label => "My fleet", :text => fleet_display}
    ]  
  end
  
  def emit_field_data
    div :class => "column span-20", :id => "show_container" do
      list.each do |hash| 
        emit_text_span_strong(8,hash[:label])
        emit_text_span(10,hash[:text])
        #        emit_empty_span(0)
      end  
    end
  end  
  
  def fleet_display
    fleet = @instance.planes
    types = @my_airline.aircrafttypes
    output = ""
    types.each do |aircrafttype|
      output << aircrafttype.name
      output << ": "
      output << "x"
      output << " units / "
    end
    return output
  end
  
  # Logic that establishes the particular parameters needed
  def set_parameters
  end
  
end


