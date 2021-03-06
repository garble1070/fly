module ActiveRecord
  class Base
    named_scope :ordered_by, lambda { |s| { :order => s } }
    named_scope :has_link, lambda { |x_model,x| {:conditions => { "#{x_model}_id" => x }}}
    
    plugins_base_url = File::join RAILS_ROOT, "vendor", "plugins"
    geokit_init_file = File::join plugins_base_url, "geokit", "init"
    geokit_rails_init_file = File::join plugins_base_url, "geokit-rails", "init"
    
    require geokit_init_file
    require geokit_rails_init_file
    
    #**********************************************#
    #            CLASS INSTANCE METHODS            #
    #**********************************************#
    
    class << self 
      
      # Returns a string representing the singular, lowercase name of the model
      def model
        table_name.singularize
      end
      
      # Returns a string representing the plural, lowercase name of the model
      def model_pl
        model.pluralize
      end
      
      # Returns a string representing the singular, capitalized name of the model
      def model_cap
        model.capitalize
      end 
      
      # Returns a symbol representing the singular, lowercase name of the model
      def model_sym
        model.to_sym
      end
      
      # Returns a target object or raises an exception if nil
      def need(target)
        if target
          target
        else
          raise RuntimeError.new("Expecting object to be not nil.")
        end
      end
      
      # Approximates static typing check for arguments
      def arg_kind_of(klass,object)
        if object.class != klass
          raise ArgumentError.new("Argument class mismatch for #{object.to_s}.")
        end
      end
      
      alias :old_method_missing :method_missing
      
      # Looks for the "code" database column in the ActiveRecord table in order to automate
      # code-based record retrieval
      def method_missing(name,*args)
        if self.new.attributes.has_key?("code")
          find_item_when_method_missing(name,*args)
        else
          old_method_missing(name,*args)
        end
      end
      
      
      # Try to find an object using the code; if not, pass it to the default method_missing
      def find_item_when_method_missing(name, *args)
        item = get_item_from_code(name)
        if item
          item
        else
          old_method_missing(name,*args)
        end
      end
      
      # Retrieve the object using the code. 
      def get_item_from_code(symbol)
        results = self.code_is(symbol.to_s)
        results.first
      end
      
      
    end
    
    
    #**********************************************#
    #               INSTANCE METHODS               #
    #**********************************************#
    
    # Returns a target object or raises an exception if nil
    def need(target)
      self.class.need(target)
    end
    
    # Approximates static typing check for arguments
    def arg_kind_of(klass,object)
      self.class.arg_kind_of(klass,object)
    end
    
    # Returns a string representing the record's "index" URL fragment (/controller).
    def controller_url
      "/" + self.class.model_pl            
    end
    
    # Returns a string representing the record's "new" URL fragment (/controller/new).
    def new_url
      self.controller_url + "/new"
    end
    
    # Returns a string representing the record's "show" URL fragment (/controller/id).
    def url
      self.controller_url + "/" + self.id.to_s
    end
    
    # Returns a string representing the record's "edit" URL fragment (/controller/id/edit).
    def edit_url
      self.url + "/edit"
    end
    
    
  end
  
end

