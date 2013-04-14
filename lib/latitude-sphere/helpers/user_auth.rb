require 'sinatra/base'

module Sinatra
  module UserAuth
    module Helpers
      @@client = nil

      def current_user
        if @@client.nil?
          client = Google::APIClient.new(:application_name => 'latitude export tool', :application_version => "0.0.1")
          client.authorization.client_id     = LatitudeSphere.client_id
          client.authorization.client_secret = LatitudeSphere.client_secret
          client.authorization.scope         = LatitudeSphere.scope
          client.authorization.redirect_uri  = LatitudeSphere.redirect_uri
          @@client = client
        end
        @@client
      end

      def latitude
        current_user.discovered_api('latitude')
      end

      def user_info
        oauth2 = current_user.discovered_api('oauth2')

        result = current_user.execute(:api_method => oauth2.userinfo.get)
        result.data
      end

      def refersh_token
        if current_user.authorization.access_token && current_user.authorization.expired?
          current_user.authorization.fetch_access_token!
        end
      end

      def authorize_code(code)
        current_user.authorization.code = code
        current_user.authorization.fetch_access_token!
        # TODO:
        # query oauth and get user info then store in db
        # set user session
      end

      def authorized?
        current_user.authorization.access_token
      end

      def authorize!
        unless authorized?
          Launchy.open current_user.authorization.authorization_uri
        end
      end
    end

    def self.registered(app)
      app.helpers UserAuth::Helpers
    end
  end

  register UserAuth
end