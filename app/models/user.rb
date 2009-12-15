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
  
  # Returns an array of all flights associated with this user
  def flights
    Flight.user_is(self)
  end
  
  # Returns an array of all operational airports associated with this user
  def ops_airports
    Airport.ops_user_is(self)
  end
  
  # Returns an array of all operational airports associated with the *friends* of this user
  def friends_ops_airports
    airports = self.friends.collect do |friend|
      friend.ops_airports
    end
    return airports.flatten.uniq
  end

  # Returns an array of all operational airports that are associated with this user's friends but
  # not with the user
  def ops_airports_exclusive_to_friends
    friends_ops_airports - self.ops_airports
  end
  
  # Gets the airilne instance associated with this user (there is only one for now but the
  # data model allows more
  def my_airline
    airlines[0]
  end
end
