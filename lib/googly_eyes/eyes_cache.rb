require 'mini_magick'
require 'yaml'

class EyesCache
  class << self
    def available_styles
      @available_styles ||= eyes_config.keys
    end

    def eyes_for(style)
      style = :default unless available_styles.include? style
      eyes.fetch(style) do |k|
        eyes[k] = {
          left: MiniMagick::Image.open("assets/#{style}/left.png"),
          right: MiniMagick::Image.open("assets/#{style}/right.png"),
          offset_x: eyes_config[style][:offset][:x],
          offset_y: eyes_config[style][:offset][:y]
        }
      end
    end

    def random_eyes
      index = rand(0..(available_styles.count - 1))
      eyes_for(available_styles[index])
    end

    def eyes
      @eyes ||= Hash.new
    end

    def eyes_config
      YAML.load_file('config/eyes.yml')
    end
  end
end
