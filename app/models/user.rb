# A unique user of the system, including login credentials
class User < ActiveRecord::Base
  has_many :accounts
  has_many :airlines
  has_many :terminals
  
  named_scope :home_airport_code_in_real_life_is, lambda { |airport_code|
    {:conditions => { "home_airport_code_real" => airport_code}}}
  
  named_scope :home_airport_code_in_game_is, lambda { |airport_code|
    {:conditions => { "home_airport_code_game" => airport_code}}}
  
  validates_presence_of     :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email, :case_sensitive => false
  before_save               :encrypt_password
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns an airport object that represents this user's home airport
  # in real life
  def home_airport_real 
    Airport.find(home_airport_code_real)
  end
  
  # Returns an airport object that represents this user's home airport
  # in the game
  def home_airport_game 
    Airport.find(home_airport_code_game)
  end
  
  # Returns an array of terminal objects that represents the complete set of
  # terminals operated by this user
  def terminals
    Terminal.owned_by_user(self.id)
  end
  
  # Returns an array of airport objects that represents the complete set of
  # locations where this user is operating terminals
  def airport_terminal_locations
    self.terminals.collect do |term_obj|
      term_obj.airport
    end
  end
end
