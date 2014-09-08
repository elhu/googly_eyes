task :console do
  $:.unshift File.join(File.dirname(__FILE__), 'lib')
  require 'irb'
  require 'irb/completion'
  require 'googly_eyes'
  ARGV.clear
  IRB.start
end

APP_FILE  = 'lib/googly_eyes.rb'
APP_CLASS = 'API'

require 'sinatra/assetpack/rake'
