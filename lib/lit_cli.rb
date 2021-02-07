require 'pry'
require 'pastel'
require 'config'
require 'lit_pry'

module LitCLI
  @@pastel = Pastel.new
  @@config = Config.new
  @@is_prying = false

  def lit(message, type = :info)
    if @@config.enabled
      return if LitCLI.filter? type
      LitCLI.render(type)
      LitCLI.step()
      LitCLI.delay()
    end
  end
  alias 🔥 lit

  def self.render(type)
    type_config = @@config.types[type]

    time_text = LitCLI.colorize(Time.now().strftime("%k:%M"), :cyan)
    type_text = type_config[:icon] + " " + type.to_s
    type_text_color = LitCLI.colorize(type_text, type_config[:color])

    message = "🔥 #{time_text} #{type_text_color} #{message}"

    puts message
  end

  def self.step()
    if @@config.step
      puts "🔥 Press ENTER to step or P to Pry:"
      input = gets.chomp
      binding while input == nil
      @@is_prying = true if input.downcase == "p"
    end
  end

  def self.filter? type
    unless @@config.type.nil? || @@config.type.include?(type)
      return true
    end

    false
  end

  def self.delay()
    if @@config.delay > 0
      sleep(@@config.delay)
    end
  end

  def self.is_prying?
    @@config.step && @@is_prying
  end

  def self.colorize(text, color)
    case color
    when :blue
      return @@pastel.bright_blue(text)
    when :green
      return @@pastel.green(text)
    when :yellow
      return @@pastel.yellow(text)
    when :red
      return @@pastel.red(text)
    when :purple, :magenta
      return @@pastel.magenta(text)
    when :cyan
      return @@pastel.cyan(text)
    else
      return text
    end
  end

  # Override config from application.
  def self.configure()
    yield(@@config)

    # Override config from command line.
    @@config.cli_configure()
  end

end
