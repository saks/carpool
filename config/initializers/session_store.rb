# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_carpool_session',
  :secret      => '5600fbaec83638bca2fc90323415522f9f2c9eb437650e2a428ad1bde72bae5d7d2510b9683e92646158c1c6bbad3ec3288ecb1448a3b72469c8842185974b92'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
