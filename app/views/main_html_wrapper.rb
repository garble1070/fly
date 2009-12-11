class Views::MainHtmlWrapper < Erector::Widgets::Page
  needs :helper_template => true
  
  external :css, "/stylesheets/project.css"
  
  # Establishes the necessary instance variables for this widget
  def prep_variables
  end
  
  # Emits the contents of the head element. Includes doctype declaration, meta and title tags, 
  # plus the stylesheet and script includes.
  def head_content
    doctype
    meta 'http-equiv' => 'content-type', :content => 'text/html;charset=UTF-8'
    page_title
    include_blueprint
    included_stylesheets
    included_scripts
  end  
  
  # Emits the page title 
  def page_title
    title "Welcome" 
  end
  
  # Emits the necessary stylesheet links for the 'blueprint' css framework
  def include_blueprint
    css "/stylesheets/blueprint/screen.css", :screen
    css "/stylesheets/blueprint/plugins/tabs/screen.css", :screen
    css "/stylesheets/blueprint/print.css", :print
    rawtext "<!--[if lt IE 8]>"
    css  "/stylesheets/blueprint/ie.css", :screen
    rawtext "<![endif]-->"
  end
  
  #  Emits a css link tag; first parameter is the href, second is the ':media' modifier
  def css(href, media=:all)
    link :rel => 'stylesheet', :type => 'text/css', :href => href, :media => media
  end
  
  # Emits the tags for the main outer container
  def body_content
    div :class => "container" do
      main_container_contents
    end
  end
  
  # Emits the main container div, the left-hand gutter, and calls following methods
  def main_container_contents
    h1 raw("&nbsp;")
    div_gutter
    widget Views::Users::ShowViewGen.new(:helper_template => @helper_template)

  end
  
end

