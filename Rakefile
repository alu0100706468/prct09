$:.unshift File.dirname(__FILE__) + 'lib'

require "bundler/gem_tasks"
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec


desc 'Ejecuta el programa de la clase en lib/fraccion.rb' 
task :bin do
  sh "ruby lib/matrix_disp.rb"
end

desc 'Ejecuta los tests con --format documentation' 
task :spec do
  sh "rspec -Ilib -Ispec -f d spec/matrix_disp_spec.rb"
end

desc 'Ejecuta los tests en formato html' 
task :thtml do
  sh "rspec -Ilib -Ispec -f h spec/matrix_disp_spec.rb"
end