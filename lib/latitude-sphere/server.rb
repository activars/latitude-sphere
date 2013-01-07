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
      erb :index
    end
  end
end