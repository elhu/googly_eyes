require 'digest/md5'
require 'mini_magick'
require 'faraday'

require 'googly_eyes/eyes_cache'
require 'googly_eyes/face'
require 'googly_eyes/face_finder'

class Googlify
  MD5 = Digest::MD5.new

  def initialize(url, eye_style = :default)
    @url = url
    blob = Faraday.new(url: @url).get.body
    @image = MiniMagick::Image.read(blob)
    @eye_style = eye_style
  end

  def googlify!
    faces = FaceFinder.new.find_faces(@url)
    faces.each do |face|
      place_googly_eyes(face)
    end
    hash = MD5.hexdigest("#{@url}:#{@eye_style}")
    filepath = "public/eyesoup/#{hash}.jpg"
    @image.write(filepath)
    filepath
  end

  private
  def place_googly_eyes(face)
    eyes = EyesCache.eyes_for @eye_style
    size_opt = @eye_style == :debug ? "" : "#{face.eye_size}x#{face.eye_size}^"
    [:left, :right].each do |side|
      pos_x = face.send("#{side}_pos")[:x] + face.eye_size * eyes[:offset_x] / 100
      pos_y = face.send("#{side}_pos")[:y] + face.eye_size * eyes[:offset_y] / 100
      @image = @image.composite(eyes[side]) do |c|
        c.compose "Over"
        c.geometry "#{size_opt}+#{pos_x}+#{pos_y}"
      end
    end
  end
end
