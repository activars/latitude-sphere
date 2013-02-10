require 'launchy'
require 'google/api_client'

module LatitudeSphere
  class Client
    attr_reader :api_client

    def initialize
      @api_client = Google::APIClient.new
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
      api_client.authorization.redirect_uri  = LatitudeSphere.redirect_uri

      Launchy.open api_client.authorization.authorization_uri
    end
  end
end