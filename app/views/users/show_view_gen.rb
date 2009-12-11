class Views::Users::ShowViewGen < Erector::Widget
  needs :helper_template => true
  
  # Establishes the necessary instance variables for this widget
  def prep_variables
    @instance = @helper_template.instance
    @my_airline = @instance.my_airline
    @home_airport_real = @instance.home_airport_real
    @home_airport_game = @my_airline.home_airport_game
  end
  
  # Generates this widget's markup output
  def content
    set_parameters
    p_blankline_hr
    emit_field_data
    3.times do p_blankline end
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
      {:label => "My fleet", :text => fleet_display},
      {:label => "", :text => ""},
      {:label => "", :text => ""},
      {:label => "", :text => ""},
      {:label => "", :text => ""},
      {:label => "", :text => ""},
      {:label => "", :text => ""},
      {:label => "", :text => ""},
      {:label => "", :text => ""},
      {:label => "", :text => ""},
      {:label => "", :text => ""},
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


