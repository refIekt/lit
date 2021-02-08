class Demo

  def run

    test = "You can access this variable via @step's Pry session."

    # Show some messages in the terminal.
    lit "Half price books at Jane's Book Emporium", :info, :advert
    lit "Amazing news, we're getting married!", :pass, :person
    lit "Danger, Will Robinson!", :warn, :robot
    lit "They've run out of ice cream Timmy", :fail, :person
    lit "I am never gonna financially recover from this", :error, :person
    lit "Life is only temporary", :debug, :person

    # Hey, I'm just a random bit of code doing some stuff.
    puts "OMG you're like together now!"
    puts "2 + 5 equals #{2 + 5}"

    long_message = %Q(
      To be, or not to be, that is the question:
      Whether 'tis nobler in the mind to suffer
      The slings and arrows of outrageous fortune,
      Or to take Arms against a Sea of troubles,
    )
    lit long_message

  end

end
