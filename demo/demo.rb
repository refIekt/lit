require_relative '../lib/api.rb'
include LitAPI

# Demo script.
lit "my message"
lit "my message", :pass
lit "my message", :fail
