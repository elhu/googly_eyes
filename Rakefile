task :console do
  $:.unshift File.join(File.dirname(__FILE__), 'lib')
  require 'irb'
  require 'irb/completion'
  require 'googly_eyes'
  ARGV.clear
  IRB.start
end
