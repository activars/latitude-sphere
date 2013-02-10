require 'sinatra/base'
require 'bundler/setup'
require 'erb'

module LatitudeSphere
  class Server < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,         "#{dir}/server/views"
    set :public_folder, "#{dir}/server/public"
    set :static, true


    get '/' do
      # TODO list authorized account
      erb :index
    end

    get '/account/login' do
      client = LatitudeSphere::Client.new
      client.authorize!
    end

    get '/account/authorized' do
      params = request.env['rack.request.query_hash']
      client = LatitudeSphere::Client.new
      client.api_client.authorization.code = params['code']
      client.api_client.authorization.fetch_access_token!

      erb :authorized
    end
  end
end