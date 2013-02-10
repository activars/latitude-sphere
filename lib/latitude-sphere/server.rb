require 'sinatra/base'
require 'bundler/setup'
require 'erb'

require 'latitude-sphere/helpers/auth'

module LatitudeSphere
  class Server < Sinatra::Base
    helpers ::Sinatra::LatitudeSphereAuth

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,         "#{dir}/server/views"
    set :public_folder, "#{dir}/server/public"
    set :static,        true

    before do
      refersh_token 
    end

    get '/' do
      # TODO list authorized account
      if authorized?
        "authorized"
      else
        "not authorized yet"
      end
      # erb :index
    end

    get '/account/login' do
      # client = LatitudeSphere::Client.new
      if authorized?
        "you are already authorized"
      else
        authorize!
      end
    end

    get '/account/authorized' do
      params = request.env['rack.request.query_hash']
      authorize_code params['code']
      "you are authorized with token #{params['code']}"
    end
  end
end