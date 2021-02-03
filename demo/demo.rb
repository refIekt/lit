require_relative '../lib/lit_cli.rb'
include LitCLI

# Demo script.
lit "my message"
lit "my message", :pass
lit "my message", :fail
