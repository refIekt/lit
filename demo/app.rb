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

  config.types = {
    :advert => { color: :red, styles: [:bold, :upcase] },
    :person => { color: :blue, styles: [:bold, :upcase] },
    :robot => { styles: [:dim, :bold, :upcase] },
  }

end

# View demo.rb to see lit in action.
demo = Demo.new
demo.run
