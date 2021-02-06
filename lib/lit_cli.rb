require 'pastel'
require 'config'

module LitCLI
  @@pastel = Pastel.new
  @@config = Config.new

  def lit(message, type = :info)
    if @@config.enabled
      return if filter? type
      render(type)
      step()
      delay()
    end
  end
  alias 🔥 lit

  def render(type)
    type_config = @@config.types[type]

    time_text = LitCLI.colorize(Time.now().strftime("%k:%M"), :cyan)
    type_text = type_config[:icon] + " " + type.to_s
    type_text_color = LitCLI.colorize(type_text, type_config[:color])

    message = "🔥 #{time_text} #{type_text_color} #{message}"

    puts message
  end

  def filter? type
    unless @@config.type.nil? || @@config.type.include?(type)
      return true
    end

    false
  end

  def step()
    if @@config.step

    end
  end

  def delay()
    if @@config.delay > 0
      sleep(@@config.delay)
    end
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

  def self.error(message)
    puts "🔥 ERROR: #{message}"
  end

end
