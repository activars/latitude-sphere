require 'thin'
require 'launchy'
require 'google/api_client'

module LatitudeSphere
  class Client
    attr_reader :host, :port, :api_client

    def initialize(host = 'localhost', port = 4567)
      @host = host
      @port = port
      @api_client = Google::APIClient.new
      authorize!
    end

    def latitude
      api_client.discovered_api('latitude', 'v1')
    end
    
    def currentLocation
      api_client.execute(:api_method => latitude.currentLocation.get)
    end

    def authorize!
      api_client.authorization.client_id     = LatitudeSphere.client_id
      api_client.authorization.client_secret = LatitudeSphere.client_secret
      api_client.authorization.scope         = LatitudeSphere.scope
      api_client.authorization.redirect_uri  = "http://#{@host}:#{@port}"

      c = api_client
      server = Thin::Server.new(@host, @port) do
        run lambda { |env|
          # Exchange the auth code & quit 
          req = Rack::Request.new(env)
          c.authorization.code = req['code']
          c.authorization.fetch_access_token!
          server.stop()
          [200, {'Content-Type' => 'text/plain'}, 'OK']
        }
      end

      Launchy.open api_client.authorization.authorization_uri
      server.start
    end
  end
end