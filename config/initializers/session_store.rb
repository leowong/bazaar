# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_store_session',
  :secret      => 'ec05229771eb6d5592e1c2cc5cf23d94505f70ff5301f8702200dbb4d69dbf356dafce60c0221d800943117744f1ee7374e9b25300d79d5fce0d97e5bed4a84f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
