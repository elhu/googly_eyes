require 'sass'

require 'json'
require 'sinatra/base'
require 'sinatra/assetpack'

require 'googly_eyes/googlify'
require 'googly_eyes/eyes_cache'


class API < Sinatra::Base
  register Sinatra::AssetPack

  assets do
    js :application, [
      "/js/lib/spin.js",
      "/js/lib/jquery.spin.js",
      "/js/lib/ZeroClipboard.min.js",
      "/js/lib/jquery.urldecoder.min.js",
      "/js/*.js"
    ]
    css :application, [
      "/css/bourbon/**/*.scss",
      "/css/base/**/*.scss",
      "/css/neat/**/*.scss",
      "/css/application.scss"
      # "/css/application.css"
    ]
    js_compression :jsmin
    # css_compression :sass
  end

  get '/googlify' do
    begin
      if params[:url]
        path = Googlify.new(params[:url], (params[:style] || :default).to_sym).googlify!
        redirect to(path)
      else
        [400, 'Please set the `url\' param']
      end
    rescue StandardError => e
      STDERR.puts e
      [415, "Error: Could not googlify image at #{params['url']}"]
    end
  end

  get '/styles' do
    (EyesCache.available_styles - [:debug]).to_json
  end

  get '/' do
    erb :index
  end
end
