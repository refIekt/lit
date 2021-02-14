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

      indent = LitCLI.render(message, status, type, context)

      LitCLI.step(indent)
      yield if block_given?

      LitCLI.delay()
    end
  end
  alias 🔥 lit

  def self.render(message, status, type, context)
    output = "🔥"

    # Time.
    time = LitCLI.format(Time.now().strftime("%k:%M"), color: :cyan)
    output << " #{time}"

    # Status.
    config = @@config.statuses[status]
    output << LitCLI.format(" #{config[:icon]} #{status.to_s}", config)

    # Type.
    if !@@config.types.nil? && @@config.types.has_key?(type)
      config = @@config.types[type]
      if config.has_key? :icon
        output << LitCLI.format(" #{config[:icon]} #{type.to_s}", config)
      else
        output << LitCLI.format(" #{type.to_s}", config)
      end
    end

    # Context.
    output << LitCLI.format(" #{context}", styles: [:bold, :dim])

    # Line break.
    while message.start_with?('^')
      message.delete_prefix!('^').strip!
      unless @@config.status || @@config.type
        output = "\n" + output
      end
    end

    # Indent.
    indent = ''
    while message.start_with?('>')
      message.delete_prefix!('>').strip!
      unless @@config.status || @@config.type
        indent = indent + '  '
        output = '  ' + output
      end
    end

    # Highlight numbers and methods.
    words = []
    message.split(/(#\d+|\w+\(\))/).each do |word|
      if word.start_with?('#') || word.end_with?(')')
        words << @@pastel.yellow(word)
      else
        words << word
      end
    end

    puts output << " " + words.join()

    return indent
  end

  def self.step(indent)
    if @@config.step
      puts "#{indent}🔥 Press ENTER to step or P to Pry:"
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
