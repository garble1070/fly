# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fly_session',
  :secret      => '9a10002e8c7de8027aac517664142390a829f1520eab21d743e2dc627bfae57b9b71cccd4d30ffa285b5473f744643829aaceac57d2523674a8bb48bfd1a962f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
