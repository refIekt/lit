################################################################################
# Usage:
#   lit <command>
#
# Example:
#   lit bundle exec rails server
################################################################################

# Enable Lit API.
ENV['LIT_ENABLED'] = 'true'

# Action original command.
command = ARGV.join " "
system command
