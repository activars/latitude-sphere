require 'launchy'
require 'google/api_client'

module Sinatra
  module LatitudeSphereAuth
    def current_user
      #TODO: check user session and return user instance 
    end

    def api_client
      @client ||= (begin
        client = Google::APIClient.new
        client.authorization.client_id     = LatitudeSphere.client_id
        client.authorization.client_secret = LatitudeSphere.client_secret
        client.authorization.scope         = LatitudeSphere.scope
        client.authorization.redirect_uri  = LatitudeSphere.redirect_uri
        client
      end)
    end

    def authorize_code(code)
      api_client.authorization.code = code
      api_client.authorization.fetch_access_token!
      # TODO:
      # query oauth and get user info then store in db
      # set user session
    end

    def authorized?
      return api_client.authorization.refresh_token && api_client.authorization.access_token
    end

    def authorize!
      unless authorized?
        Launchy.open api_client.authorization.authorization_uri
      end
    end
  end

  helpers LatitudeSphereAuth
end