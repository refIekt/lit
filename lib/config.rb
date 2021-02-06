module LitCLI

  ##############################################################################
  # Default config that can be overridden from the command line or application.
  #
  # @usage:
  #   LitCLI.configure do |config|
  #     config.<property> = <value>
  #   end
  #
  # @precedence:
  #   3. Defaults - initialize()
  #   2. Application - LitCLI.configure()
  #   1. Command line flags - cli_configure()
  ##############################################################################

  class Config

    attr_accessor :enabled
    attr_accessor :types
    attr_accessor :type
    attr_accessor :step
    attr_accessor :delay

    def initialize()

      @types = {
        :info => { icon: "ℹ", color: :blue },
        :pass => { icon: "✔", color: :green },
        :warn => { icon: "⚠", color: :yellow },
        :fail => { icon: "⨯", color: :red },
        :error => { icon: "!", color: :red },
        :debug => { icon: "?", color: :purple },
      }

      # Lit is disabled by default, then enabled via the `lit` command.
      # Or it can be permanently enabled, without the use of the `lit` command.
      @enabled = false

      ##
      # FLAGS.
      #
      # Flag defaults when not supplied via command line.
      ##

      # Array of types to filter by, for example... [:warn, :error, :fail]
      @type = nil

      # Boolean on whether or not to step through each lit() breakpoint.
      @step = false

      # Integer or float representing amount of seconds to delay each lit() by.
      @delay = 0

      cli_configure()
    end

    # Override config from command line.
    def cli_configure()
      @enabled = true if ENV['LIT_ENABLED'] == 'true'

      # Convert flag string to hash.
      flags = {}
      if ENV['LIT_FLAGS'] && !ENV['LIT_FLAGS'].empty?
        ENV['LIT_FLAGS'].split().each do |flag|
          values = flag.split('=')

          key = values.shift.to_sym
          args = values.split(',')

          # No arguments.
          if args.empty?
            flags[key] = {}
          else
            # Single argument.
            if args.count = 1
              flags[key] = args.first
            # Multiple arguments.
            else
              flags[key] = args
            end
          end
        end
      end

      @type = flags[:type] if flags.has_key? :type
      @step = true if flags.has_key? :step
      @delay = flags[:delay] if flags.has_key? 'delay'
    end

  end
end
