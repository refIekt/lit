# Only override kernel methods when Lit's @step flag is true.
if ENV['LIT_ENABLED'] && ENV['LIT_ENABLED'].to_i >= (Time.now.to_i() - 1) && ENV['LIT_FLAGS'] && ENV['LIT_FLAGS'].include?('step')
  require 'set'

  # TODO: Investigate RubyGems `require` before overriding.
  # SEE: https://github.com/ruby/ruby/blob/v2_6_3/lib/rubygems/core_ext/kernel_require.rb

  module Kernel

    @@lit_processed_paths = Set.new

    def require_relative relative_path, current_directory = nil
      return false if relative_path.nil?

      # Handle absolute path.
      if relative_path.start_with?('/') && File.exist?(relative_path)
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

      unless @@lit_processed_paths.include? file_path
        @@lit_processed_paths.add file_path

        new_lines = ''
        line_count = 0
        new_lines_count = 0

        File.foreach(file_path) do |line|
          line_count = line_count + 1

          # Pass current directory into the next file's requires.
          if line.strip.start_with? 'require_relative '
            line = line.strip + ", '#{absolute_path.join('/')}'\n"
            new_lines << line
          # Add pry binding on each lit method.
          elsif lit_line = Kernel.add_lit_binding(line)
            new_lines << lit_line
          else
            new_lines << line
          end
        end

        eval(new_lines, get_binding(__dir__ = absolute_path), file_path)

        return true
      # Path has already been required.
      else
        return false
      end
    end

    def get_binding(__dir__)
      # Don't go to this binding when Pry session activated.
      # The variables have already been evaluated by eval(). NEEDS CONFIRMATION.
      # Setting file_path in eval() negates this fix but will keep just in case.
      return binding unless LitCLI.is_prying?
    end

    def self.add_lit_binding(line)
      ['lit ', 'lit(', '🔥 ', '🔥(', '🔥'].each do |needle|
        if line.strip.start_with? needle
          args = line.strip.delete_prefix(needle).delete_suffix(")").chomp
          return "lit(#{args}) { binding.pry if LitCLI.is_prying?; @@is_prying = false } \n"
        end
      end

      false
    end
  end
end
