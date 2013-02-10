module LatitudeSphere
  module Scope
    extend self
    
    def all_best
      'https://www.googleapis.com/auth/latitude.all.best'
    end

    def current_best
      'https://www.googleapis.com/auth/latitude.current.best'
    end

    def all_city
      'https://www.googleapis.com/auth/latitude.all.city'
    end

    def current_city
      'https://www.googleapis.com/auth/latitude.current.city'
    end

    def user_profile
      'https://www.googleapis.com/auth/userinfo.profile'
    end
  end
end