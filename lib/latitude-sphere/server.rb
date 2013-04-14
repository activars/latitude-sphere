require 'sinatra/base'
require 'bundler/setup'
require 'erb'
require 'latitude-sphere/helpers/user_auth'
require 'latitude-sphere/helpers/batch_exporter'

module LatitudeSphere
  class Server < Sinatra::Base
    register Sinatra::UserAuth
    register Sinatra::BatchExporter

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,         "#{dir}/server/views"
    set :public_folder, "#{dir}/server/public"
    set :static,        true
    set :sessions,      true

    before do
      refersh_token
    end

    get '/' do
      # TODO list authorized account
      if authorized?
        "you are authorized #{user_info['email']}"
      else
        "not authorized yet"
      end
      # erb :index
    end

    get '/locations/export' do
      params  = request.env['rack.request.query_hash']
      batches = batch_export({
        :api_method => latitude.location.list,
        :max_time   => params['max_time'],
        :min_time   => params['min_time'],
        :email      => user_info['email'],
        :client     => current_user
      })

      current_user.execute(batches)
    end

    get '/account/login' do
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