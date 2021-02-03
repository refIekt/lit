require_relative '../lib/lit_cli.rb'
include LitCLI

################################################################################
# Usage:
#   lit ruby demo/demo.rb
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

# Show some messages in the terminal.
lit "Half price books at Jane's Book Emporium"
lit "Amazing news, we're getting married", :pass
lit "Danger, Will Robinson!", :warn
lit "They've run out of ice cream Timmy", :fail
lit "I am never gonna financially recover from this", :error
lit "Life is only temporary", :debug

# Hey, I'm just a random bit of code doing some stuff.
add_me = 2 + 5
log_me = "OMG you're like together now!"
puts log_me + " " + add_me.to_s

long_message = %Q(
  To be, or not to be, that is the question:
  Whether 'tis nobler in the mind to suffer
  The slings and arrows of outrageous fortune,
  Or to take Arms against a Sea of troubles,
)
lit long_message
