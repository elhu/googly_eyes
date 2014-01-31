require 'sinatra'

$:.unshift File.join(File.dirname(__FILE__), 'lib')

map "/public" do
  run Rack::Directory.new("./public")
end

map "/javascripts" do
  run Rack::Directory.new("./public/javascripts")
end

disable :run, :reload

require 'googly_eyes/api'

run API
