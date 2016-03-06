class Face
  def initialize(opts)
    @left_eye = opts[:left_eye]
    @right_eye = opts[:right_eye]
    @width = opts[:width]
  end

  def left_pos
    {
      x: @left_eye[:x] - (eye_size / 2),
      y: @left_eye[:y] - (eye_size / 2)
    }
  end

  def right_pos
    {
      x: @right_eye[:x] - (eye_size / 2),
      y: @right_eye[:y] - (eye_size / 2)
    }
  end

  def eye_size
    # 3.8 is the magic eye to face width ratio
    @eye_size ||= @width / 3.8
  end
end
