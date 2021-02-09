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
    :info => { icon: "ℹ", color: :blue, styles: [:upcase] },
    :pass => { icon: "✔", color: :green, styles: [:upcase] },
    :warn => { icon: "⚠", color: :yellow, styles: [:upcase] },
    :fail => { icon: "⨯", color: :red, styles: [:upcase] },
    :error => { icon: "!", color: :red, styles: [:upcase] },
    :debug => { icon: "?", color: :purple, styles: [:upcase] },
  }
  # Add message types representing this application's data types.
  config.types = {
    :advert => { color: :red, styles: [:bold, :capitalize] },
    :person => { color: :blue, styles: [:bold, :capitalize] },
    :robot => { styles: [:dim, :bold, :capitalize] },
  }
end

# Run the demo. See demo.rb to see lit() messages in action.
demo = Demo.new
demo.run
