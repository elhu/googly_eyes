require 'sinatra/base'

require 'googly_eyes/googlify'

class API < Sinatra::Base
  get '/googlify' do
    if params[:url]
      path = Googlify.new(params[:url]).googlify!
      [200, "#{request.scheme}://#{request.host}/#{path}"]
    else
      [400, 'Please set the `url\' param']
    end
  end
end
