# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cg-processor_session',
  :secret      => '6752816e57dc12d856491c3381853509c963dc302b1d15ec569a8a06bf81c7642ad838eb0166f41306641309961c84d0f847ed950ab093111b71681d5ec3a4cb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
