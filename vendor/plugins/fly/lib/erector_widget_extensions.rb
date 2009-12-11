module Erector
  class Widget
    
    # Overrides the base Erector constructor to call the 'prep-variables' method at the end of
    # the instantiation process
    def initialize(assigns={}, &block)
      unless assigns.is_a? Hash
        raise "Erector's API has changed. Now you should pass only an options hash into Widget.new; the rest come in via to_s, or by using #widget."
      end
      @assigns = assigns
      assign_instance_variables(assigns)
      unless @parent
        @parent = block ? eval("self", block.binding) : nil
      end
      @block = block
      self.class.after_initialize self
      prep_variables
    end
    
    # Dummy method that should be overriden in instantiated widgets
    def prep_variables
    end
    
    # Emits a non-breaking space
    def nbsp
      rawtext("&nbsp;")
    end
    
    # Emits a class-div with column span of 1
    def div_gutter
      div :class => "column span-1" do 
        nbsp
      end
    end
    
    # Emits a blank paragraph
    def p_blankline
      p do
        nbsp
      end
    end
    
    # Emits a blank paragraph
    def p_blankline_hr
      p :class => "underline" do
        nbsp
      end
    end
    
    # Emits a blank listitem entry
    def li_blankline
      li do
        nbsp
      end
    end
    
    # Emits five non-breaking spaces
    def five_spaces
      5.times do
        nbsp
      end
    end
    
    # Emits a raw text href string with an appropriate column 'div' parameter
    def emit_link_span(colspan, linktext, href, link_class=nil, options_hash={}, helper_template=nil)
      options_hash[:href] = href
      if link_class
        options_hash[:class] = link_class
      end
      div :class => "column span-#{colspan}" do
        if helper_template
           rawtext(helper_template.link_to(linktext,href,options_hash))
        else
          a options_hash do
            text linktext
          end
        end
      end
    end
    
    # Emits a raw text href string surrounded by non-breaking spaces
    def emit_button_span(linktext, href, link_class=nil, options_hash={}, helper_template=nil)
      2.times do nbsp end
      options_hash[:href] = href
      if link_class
        options_hash[:class] = link_class
      end
      if helper_template
        rawtext(helper_template.link_to(linktext,href,options_hash))
      else
        a options_hash do
          rawtext linktext
        end
      end
      2.times do nbsp end
    end
    
    # Emits an escaped text string with an appropriate column 'div' parameter
    def emit_text_span(colspan, textline, text_class=nil, options_hash={})
      div :class => "column span-#{colspan}"  do
        if text_class || options_hash.length > 0
          if text_class
            options_hash[:class] = text_class
          end
          span options_hash do
            text(textline)
          end
        else
          text(textline)
        end        
      end
    end
    
    # Emits a non-breaking space with an appropriate column 'div' parameter
    def emit_empty_span(colspan)
      div :class => "column span-#{colspan}"  do
        nbsp
      end
    end
    
    # Emits an escaped text string using the "strong" tag and an appropriate column 'div' parameter
    def emit_text_span_strong(colspan, textline, text_class=nil, options_hash={})
      if text_class
        options_hash[:class] = text_class
      end
      div :class => "column span-#{colspan}"  do
        strong options_hash do
          text(textline)
        end
      end
    end
    
  end
end
