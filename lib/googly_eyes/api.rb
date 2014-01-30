require 'sinatra/base'

require 'googly_eyes/googlify'

class API < Sinatra::Base
  get '/googly-eyes' do
    path = Googlyfy.new(params[:url]).googlyfy!
    [200, 'placeholder']
  end
end
