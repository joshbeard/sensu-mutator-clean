#!/usr/bin/env ruby
#
# Clean
# ===
#
# DESCRIPTION:
#   This mutator simply removes empty lines from the output and transforms
#   the output to lowercase.
#
# OUTPUT:
#   Empty lines are removed, as they cause errors in Graphite.  Also transforms
#   output to lowercase for consistency
#
# PLATFORM:
#   all
#
# DEPENDENCIES:
#   none
#
# Copyright 2015 Josh Beard
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.
require 'json'

# parse event
event = JSON.parse(STDIN.read, symbolize_names: true)

# remove empty lines
output = event[:check][:output].gsub!(/^$\n/, '')

# convert dots in fqdn to underscores
output.gsub!(event[:client][:name], event[:client][:name].gsub('.', '_'))

# convert to lowercase
if ARGV[0] == '-l' || ARGV[0] == '--lowercase'
  output.downcase!
end

puts output
