# A unique user of the system, including login credentials
class User < ActiveRecord::Base
  has_many :accounts
  has_many :airlines
  has_many :terminals,
     :through => :airlines
  has_many :planes ,
           :through => :airlines
  has_one :home_airport_real, 
  
      :class_name => "Airport",
      :foreign_key => "code",
      :primary_key => "home_airport_code_real"
      
  has_one :home_airport_game, 
      :class_name => "Airport",
      :foreign_key => "code",
      :primary_key => "home_airport_code_game"
            
  has_many :friendships
  has_many :friends, 
           :through => :friendships,
           :conditions => "status = 'accepted'", 
           :order => :first_name

  has_many :requested_friends, 
           :through => :friendships, 
           :source => :friend,
           :conditions => "status = 'requested'", 
           :order => :created_at

  has_many :pending_friends, 
           :through => :friendships, 
           :source => :friend,
           :conditions => "status = 'pending'", 
           :order => :created_at

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
  
    
end
