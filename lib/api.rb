#!/usr/bin/env ruby

filename = ARGV.shift
matrices = File.open(filename).read
matrices = <<"EXAM"
	require './matrix_disp.rb'

	Math::Api.new("suma") do 
		#{matrices}
	end
EXAM
puts "-------------------"
matrix = eval matrices
matrix.run