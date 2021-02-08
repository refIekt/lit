require 'lit_cli'
require_relative 'demo'
include LitCLI

################################################################################
# Usage:
#   lit ruby demo/app.rb
################################################################################

LitCLI.configure do |config|
  # Override the default message statuses.
  config.statuses = {
    :info => { icon: "ℹ", color: :blue },
    :pass => { icon: "✔", color: :green },
    :warn => { icon: "⚠", color: :yellow },
    :fail => { icon: "⨯", color: :red },
    :error => { icon: "!", color: :red },
    :debug => { icon: "?", color: :purple },
  }
  # Add message types representing this application's data types.
  config.types = {
    :advert => { color: :red, styles: [:bold, :upcase] },
    :person => { color: :blue, styles: [:bold, :upcase] },
    :robot => { styles: [:dim, :bold, :upcase] },
  }
end

# Run the demo. See demo.rb to see lit() messages in action.
demo = Demo.new
demo.run
