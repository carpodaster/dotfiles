#!/usr/bin/env ruby
# encoding: utf-8

# http://holmwood.id.au/~lindsay/2008/01/04/textmate-links-firefox/

unless ARGV[0] =~ /^txmt:\/\/open\?url=/ then
    puts "You probably want this called from firefox with a txmt url."
    exit 1
end

args = ARGV[0].split("://")

file = args[2].split("&")[0]
line = args[2].split("line=")[1]
line = "1" if line == "?"

`mvim +#{line} --remote-tab #{file}`
