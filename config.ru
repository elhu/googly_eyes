require 'sinatra'

$:.unshift File.join(File.dirname(__FILE__), 'lib')

disable :run, :reload

require 'googly_eyes/api'

run API
