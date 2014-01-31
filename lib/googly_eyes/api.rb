require 'json'
require 'sinatra/base'

require 'googly_eyes/googlify'
require 'googly_eyes/eyes_cache'

class API < Sinatra::Base
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
    EyesCache.available_styles.to_json
  end

  get '/' do
    [200, 'Endpoint is at /googlify']
  end
end
