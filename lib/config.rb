module LitCLI
  class Config

    attr_accessor :types

    def initialize()
      @types = {
        :info => { icon: "ℹ", color: :blue },
        :pass => { icon: "✔", color: :green },
        :warn => { icon: "⚠", color: :yellow },
        :fail => { icon: "⨯", color: :red },
        :error => { icon: "!", color: :red },
        :debug => { icon: "?", color: :purple },
      }
    end

  end
end
