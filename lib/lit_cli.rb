require 'pry'
require 'pastel'
require 'config'
require 'lit_pry'

module LitCLI
  @@pastel = Pastel.new
  @@config = Config.new
  @@is_prying = false

  def lit(message, status = :info, type = nil, context = nil)
    if @@config.enabled
      return if LitCLI.filter_status? status
      return if LitCLI.filter_type? type

      LitCLI.render(message, status, type, context)

      LitCLI.step()
      yield if block_given?

      LitCLI.delay()
    end
  end
  alias 🔥 lit

  def self.render(message, status, type, context)
    text = "🔥"

    # Time.
    time = LitCLI.format(Time.now().strftime("%k:%M"), color: :cyan)
    text << " #{time}"

    # Status.
    config = @@config.statuses[status]
    text << LitCLI.format(" #{config[:icon]} #{status.to_s}", config)

    # Type.
    if !@@config.types.nil? && @@config.types.has_key?(type)
      config = @@config.types[type]
      if config.has_key? :icon
        text << LitCLI.format(" #{config[:icon]} #{type.to_s}", config)
      else
        text << LitCLI.format(" #{type.to_s}", config)
      end
    end

    # Context.
    text << LitCLI.format(" #{context}", styles: [:bold, :dim])

    # Message.
    text << " #{message}"

    puts text
  end

  def self.step()
    if @@config.step
      puts "🔥 Press ENTER to step or P to Pry:"
      input = gets.chomp
      binding while input == nil
      @@is_prying = true if input.downcase == "p"
    end
  end

  def self.filter_status? status
    unless @@config.status.nil? || @@config.status.include?(status)
      return true
    end

    false
  end

  def self.filter_type? type
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

  def self.format(text, config)

    if config.has_key? :styles
      # Change characters first.
      config[:styles].each do |style|
        case style
        when :upcase
          text = text.upcase
        when :downcase
          text = text.downcase
        when :capitalize
          text = text.capitalize
        end
      end
      # Then apply styling.
      config[:styles].each do |style|
        case style
        when :clear
          text = @@pastel.clear(text)
        when :bold
          text = @@pastel.bold(text)
        when :dim
          text = @@pastel.dim(text)
        when :italic
          text = @@pastel.italic(text)
        when :underline
          text = @@pastel.underline(text)
        when :inverse
          text = @@pastel.inverse(text)
        when :hidden
          text = @@pastel.hidden(text)
        when :strike, :strikethrough
          text = @@pastel.strikethrough(text)
        end
      end
    end

    if config.has_key? :color
      case config[:color]
      when :blue
        text = @@pastel.bright_blue(text)
      when :green
        text = @@pastel.green(text)
      when :yellow
        text = @@pastel.yellow(text)
      when :red
        text = @@pastel.red(text)
      when :purple, :magenta
        text = @@pastel.magenta(text)
      when :cyan
        text = @@pastel.cyan(text)
      end
    end

    text
  end

  # Override config from application.
  def self.configure()
    yield(@@config)

    # Override config from flags on command line.
    @@config.cli_configure()
  end

end
