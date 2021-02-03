require 'pastel'

module LitCLI

  @@pastel = Pastel.new

  def lit(message, status = :info)

    if ENV['LIT_ENABLED'] == 'true'

      time = Time.now().strftime("%k:%M")
      status_style = status.to_s.upcase
      status_icons = {
        :info => "ℹ",
        :pass => "✔",
        :fail => "⨯"
      }

      message = "🔥 #{time}: #{message} (#{status_icons[status]} #{status_style})"

      case status
      when :info
        puts @@pastel.bright_blue(message)
      when :pass, :success
        puts @@pastel.green(message)
      when :fail
        puts @@pastel.red(message)
      end

    end
  end
  alias 🔥 lit

end
