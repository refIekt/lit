require 'set'

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

    # Track errors and only show them once.
    @@errors = Set.new

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

          # No arguments.
          if values.empty?
            flags[key] = nil
          else
            args = values.pop.split(',')
            # Single argument.
            if args.count == 1
              flags[key] = args.first
            # Multiple arguments.
            else
              flags[key] = args
            end
          end
        end
      end

      @step = true if flags.has_key? :step
      @type = Array(flags[:type]).map(&:to_sym) if valid? flags, :type
      @delay = flags[:delay].to_f if valid? flags, :delay
    end

    def valid? flags, flag
      # Has flag even been entered on the command line?
      unless flags.has_key? flag
        return false
      end

      if flags[flag].nil?
        error = "🔥 ERROR: Invalid argument for @#{flag}."
        unless @@errors.include? error
          @@errors.add error
          puts error
        end
        return false
      end

      true
    end

  end
end
