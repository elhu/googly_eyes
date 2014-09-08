require 'json'

require 'googly_eyes/face'
require 'googly_eyes/config'

class FaceFinder
  BASE_URL = 'http://rekognition.com'
  ENDPOINT = '/func/api/'

  API_KEY = Config.api_key
  API_SECRET = Config.api_secret

  def initialize
    @conn = Faraday.new(url: BASE_URL)
  end

  def find_faces(url)
    options = {
      api_key: API_KEY,
      api_secret: API_SECRET,
      jobs: %w(face part).join('_'),
      urls: url
    }
    resp = @conn.post ENDPOINT, options
    data = JSON.parse(resp.body)
    puts data
    (data["face_detection"] || []).map do |face_attrs|
      Face.new({
        left_eye: face_attrs["eye_left"],
        right_eye: face_attrs["eye_right"],
        width: face_attrs["boundingbox"]["size"]["width"]
      })
    end
  end
end
