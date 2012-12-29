module LatitudeSphere
  class Client
    def initialize
      @oauth_client = LatitudeSphere::LatitudeClient.new
      @authorization =  @oauth_client.authorize!
    end
  end
end