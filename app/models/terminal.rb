class Terminal < ActiveRecord::Base
  belongs_to :user
  belongs_to :airport, :foreign_key => "airport_code"

  named_scope :owned_by_user, lambda { |user_id|
    {:conditions => { "user_id" => user_id}}}
  
  # Returns the airport object (i.e. the parent) for this terminal
#  def airport
#    Airport.find(self.airport_code)
#  end
  
  
end
