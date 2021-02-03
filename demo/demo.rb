require_relative '../lib/lit_cli.rb'
include LitCLI

################################################################################
# Usage:
#   lit ruby demo/demo.rb
################################################################################

LitCLI.configure do |config|
  # Override the default message types.
  config.types = {
    info: { icon: "ℹ", color: :blue },
    pass: { icon: "✔", color: :green },
    warn: { icon: "⚠", color: :yellow },
    fail: { icon: "⨯", color: :red },
    debug: { icon: "?", color: :purple }
  }
end

# Show some messages in the terminal.
lit "I just thought you should know that's all"
lit "An amazing thing has happened", :pass
lit "It could be better, but it could also be worse", :warn
lit "Danger, Will Robinson!", :fail
lit "Life is only temporary", :debug
