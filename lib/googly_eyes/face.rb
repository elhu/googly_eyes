class Face
  attr_accessor :left_eye, :right_eye, :width

  def initialize(opts)
    self.left_eye = opts[:left_eye]
    self.right_eye = opts[:right_eye]
    self.width = opts[:width]
  end

  def left_pos
    {
      x: left_eye["x"] - (eye_size / 2),
      y: left_eye["y"] - (eye_size / 2)
    }
  end

  def right_pos
    {
      x: right_eye["x"] - (eye_size / 2),
      y: right_eye["y"] - (eye_size / 2)
    }
  end

  def eye_size
    @eye_size ||= width / 3.8
  end
end
