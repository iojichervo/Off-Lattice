#!/usr/bin/env ruby

require './cim/cim.rb'

m = ARGV[0].to_i
rc = ARGV[1].to_f
state = state(m, rc)