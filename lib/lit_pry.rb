# Only override kernel methods when Lit's @step flag is true.
if ENV['LIT_FLAGS'] && ENV['LIT_FLAGS'].include?('step')
  module Kernel

    def require_relative relative_path
      filename = relative_path

      # Get directory of the file that called this file.
      absolute_path = caller_locations.first.absolute_path.split('/')
      absolute_path.pop

      # When relative path is current directory.
      if relative_path.start_with?('./')
        filename = relative_path.delete_prefix! './'
      end

      # When relative path is parent directory.
      while relative_path.start_with?('../')
        relative_path.delete_prefix! '../'
        absolute_path.pop
      end

      # Append default extension.
      unless filename.end_with? '.rb'
        filename << '.rb'
      end

      filepath = File.join(absolute_path.join('/'), relative_path)

      # Add pry binding beneath each lit message.
      new_lines = ''
      File.foreach(filepath) do |line|
        new_lines << line
        if line.strip.start_with? 'lit "'
          new_lines << "binding.pry if LitCLI.is_prying?\n"
          new_lines << "@@is_prying = false\n"
        end
      end

      eval(new_lines)
    end

    # TODO: Investigate RubyGems `require` before overriding.
    # SEE: https://github.com/ruby/ruby/blob/v2_6_3/lib/rubygems/core_ext/kernel_require.rb
    #
    # def require path
    #   absolute_path = File.join(Dir.pwd, path)
    #   #p "requiring #{absolute_path}"
    #   #p __dir__
    #   #p File.dirname(File.realpath(__FILE__))
    #   #p File.realpath(__FILE__)
    #
    #   # Split client-side and server-side code.
    #   new_lines = []
    #   binding_line = "binding.pry if LitCLI.is_prying?"
    #
    #   # Add pry binding beneath each lit message.
    #   p path
    #   File.foreach(path) do |line|
    #     new_lines << line
    #     if line.strip.start_with? 'lit "'
    #       new_lines << binding_line
    #     end
    #   end
    #
    #   eval(new_lines.join)
    # end

  end
end
