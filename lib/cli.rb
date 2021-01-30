################################################################################
# Usage:
#   lit <command>
#
# Example:
#   lit bundle exec rails server
################################################################################

# Enable the API.
ENV['LIT_ENABLED'] = 'true'

# Action original command.
command = ARGV.join " "
system command
