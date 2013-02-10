require 'latitude-sphere/version'


require 'latitude-sphere/client'
require 'latitude-sphere/scope'
require 'latitude-sphere/server'


module LatitudeSphere
  extend self
  attr_accessor :client_id, :client_secret, :scope, :redirect_uri

  def client_id
    @client_id || argument_error('client_id')
  end

  def client_secret
    @client_secret || argument_error('client_secret')
  end

  def redirect_uri
    @redirect_uri || argument_error('redirect_uri')
  end

  def scope
    @scope ||= "#{Scope.all_best} #{Scope.current_best} #{Scope.user_profile}" 
  end

  private
  def argument_error(name)
    raise "configure #{name} by assigning Sphere.#{name}"
  end

end
