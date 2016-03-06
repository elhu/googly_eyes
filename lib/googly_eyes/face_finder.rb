require 'json'
require 'ropencv'

require 'googly_eyes/face'

class FaceFinder
  attr_accessor :faces

  FACE_CLASSIFIER = OpenCV::Cv::CascadeClassifier.new.tap do |classifier|
    classifier.load('./data/haarcascades/haarcascade_frontalface_alt.xml')
  end

  EYE_CLASSIFIER = OpenCV::Cv::CascadeClassifier::new.tap do |classifier|
    classifier.load('./data/haarcascades/haarcascade_eye.xml')
  end

  def initialize
    self.faces = OpenCV::Std::Vector.new(OpenCV::Cv::Rect)
  end

  def find_faces(data)
    buff = OpenCV::Cv::Mat.new(1, data.length, OpenCV::cv::CV_8U, data);
    image = OpenCV::Cv::imdecode(buff, 1)
    grayscale = OpenCV::Cv::Mat.new
    OpenCV::Cv::cvt_color(image, grayscale, OpenCV::Cv::COLOR_BGR2GRAY, 0)

    FACE_CLASSIFIER.detect_multi_scale(grayscale, faces, 1.3, 4)
    faces.map do |face|

      # Debug info
      # face_color = OpenCV::Cv::Scalar.new(0, 0, 255)
      # eye_color = OpenCV::Cv::Scalar.new(0, 255, 0)
      # OpenCV::Cv.rectangle(image, face.tl, face.br, face_color)

      roi_gray = grayscale.block(face)
      roi_color = image.block(face)

      eyes = OpenCV::Std::Vector.new(OpenCV::Cv::Rect)
      EYE_CLASSIFIER.detect_multi_scale(roi_gray, eyes, 1.15, 5)
      eye_coords = eyes.map do |eye|
        # Debug info
        # OpenCV::Cv.rectangle(roi_color, eye.tl, eye.br, eye_color)
        {
          x: face.x + eye.x + eye.width / 2,
          y: face.y + eye.y + eye.height / 2
        }
      end
      Face.new({
        left_eye: eye_coords[-2],
        right_eye: eye_coords[-1],
        width: face.width
      })
    end
  end
end
