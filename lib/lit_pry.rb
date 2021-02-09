# Only override kernel methods when Lit's @step flag is true.
if ENV['LIT_FLAGS'] && ENV['LIT_FLAGS'].include?('step')
  module Kernel

    def require_relative relative_path, current_directory = nil
      unless relative_path.nil?

        # Handle absolute path.
        if File.exist? relative_path
          absolute_path = relative_path.split('/')
          file_name = absolute_path.pop
        # Handle relative path.
        else
          # Get directory of the file that called this file.
          if current_directory.nil?
            absolute_path = caller_locations.first.absolute_path.split('/')
            absolute_path.pop
          else
            absolute_path = current_directory.split('/')
          end

          # When path is current directory.
          if relative_path.start_with?('./')
            relative_path.delete_prefix! './'
          end

          # When path is parent directory.
          while relative_path.start_with?('../')
            relative_path.delete_prefix! '../'
            absolute_path.pop
          end

          # When path contains child directories.
          if relative_path.split('/').count > 1
            # Add child directories to absolute path and remove from relative path.
            child_path = relative_path.split('/')
            relative_path = child_path.pop
            child_path.each do |dir|
              absolute_path << dir
            end
          end

          file_name = relative_path
        end

        # Append default extension.
        unless file_name.end_with? '.rb'
          file_name << '.rb'
        end

        file_path = File.join(absolute_path.join('/'), file_name)
        p file_path

        # Add pry binding beneath each lit message.
        new_lines = ''
        File.foreach(file_path) do |line|
          if line.strip.start_with? 'require_relative '
            line = line.strip + ", '#{absolute_path.join('/')}'\n"
            new_lines << line
          else
            new_lines << line
          end

          if line.strip.start_with? 'lit "'
            new_lines << "binding.pry if LitCLI.is_prying?\n"
            new_lines << "@@is_prying = false\n"
          end
        end

        eval(new_lines, get_binding(__dir__ = absolute_path))
      else
        super
      end
    end

    def get_binding(__dir__)
      return binding
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
