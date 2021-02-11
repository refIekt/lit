class Demo
  def run
    notice = "You can access these variables via @step flag's Pry session."

    # Show lit messages in the terminal while doing random stuff.
    lit "Half price books at Jane's Book Emporium", :info, :advert
    discounts = [0.20, 0.40, 0.50, 0.80, 0.99]

    lit "Amazing news, we're getting married!", :pass, :person
    rules = "Gift policy: Please bring 1 shucked oyster per person."

    lit "Danger, Will Robinson!", :warn, :robot
    robot_kill_mode = [true, false].sample

    lit "They've run out of ice cream Timmy", :fail, :person
    grandparents = {anne: "awesome", david: "kind"}

    lit "I am never gonna financially recover from this", :error, :person
    amount_owing = 5 * 5 * 5 * 5 * 5 * 5 * 5 * 5 * 5

    🔥 "Life is only temporary", :debug, :person
    woke = true

    # Hey, I'm just a random bit of code doing some stuff.
    puts "OMG you're like together now!"
    puts "2 + 5 equals #{2 + 5}"

    # Hey, I'm just a long message on multiple lines.
    long_message = %Q(
      To be, or not to be, that is the question:
      Whether 'tis nobler in the mind to suffer
      The slings and arrows of outrageous fortune,
      Or to take Arms against a Sea of troubles,
    )
    lit long_message
  end
end
