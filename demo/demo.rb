class Demo
  def run
    notice = "You can access these variables via @step flag's Pry session."

    # Show lit messages in the terminal while doing random stuff.
    lit "Half price books at Jane's Book Emporium", :info, :advert
    discounts = [0.20, 0.40, 0.50, 0.80, 0.99]

    lit "Amazing news, we're getting married!", :pass, :person
    rules = "Gift policy: Please bring 1 shucked oyster per person."
    puts "Random output 1"

    lit "Danger, Will Robinson!", :warn, :robot
    robot_kill_mode = [true, false].sample

    lit "They've run out of ice cream Timmy", :fail, :person
    grandparents = {anne: "awesome", david: "kind"}
    puts "Random output 2"

    lit "I am never gonna financially recover from this", :error, :person
    amount_owing = 5 * 5 * 5 * 5 * 5 * 5 * 5 * 5 * 5

    🔥 "The meaning of life is to find meaning", :debug, :person
    woke = true

    # Hey, I'm just a random bit of code doing some stuff.
    puts "2 + 5 equals #{2 + 5}"
  end
end
