require 'digest/md5'
require 'mini_magick'
require 'faraday'

require 'googly_eyes/face'
require 'googly_eyes/face_finder'

class Googlify
  LEFT_EYE = MiniMagick::Image.open('assets/left.png')
  RIGHT_EYE = MiniMagick::Image.open('assets/right.png')
  MD5 = Digest::MD5.new

  def initialize(url)
    @url = url
    blob = Faraday.new(url: @url).get.body
    @image = MiniMagick::Image.read(blob)
  end

  def googlify!
    faces = FaceFinder.new.find_faces(@url)
    faces.each do |face|
      place_googly_eyes(face)
    end
    filepath = "public/eyesoup/#{MD5.hexdigest(@url)}.jpg"
    @image.write(filepath)
    filepath
  end

  private
  def place_googly_eyes(face)
    size_opt = "#{face.eye_size}x#{face.eye_size}^"
    @image = @image.composite(LEFT_EYE) do |c|
      c.compose "Over"
      c.geometry "#{size_opt}+#{face.left_pos[:x]}+#{face.left_pos[:y]}"
    end
    @image = @image.composite(RIGHT_EYE) do |c|
      c.compose "Over"
      c.geometry "#{size_opt}+#{face.right_pos[:x]}+#{face.right_pos[:y]}"
    end
  end
end
