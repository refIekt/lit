require 'lit_cli'
require_relative 'demo'
include LitCLI

################################################################################
# Usage:
#   lit ruby demo/app.rb
################################################################################

LitCLI.configure do |config|
  # Override the default message types.
  config.types = {
    :info => { icon: "ℹ", color: :blue },
    :pass => { icon: "✔", color: :green },
    :warn => { icon: "⚠", color: :yellow },
    :fail => { icon: "⨯", color: :red },
    :error => { icon: "!", color: :red },
    :debug => { icon: "?", color: :purple },
  }
end

# View demo.rb to see lit in action.
demo = Demo.new
demo.run
