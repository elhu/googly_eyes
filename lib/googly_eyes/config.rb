require 'yaml'
require 'ostruct'

Config = OpenStruct.new(YAML.load_file('config/rekognition.yml'))
