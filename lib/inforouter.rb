require 'savon'

require 'inforouter/access_list'
require 'inforouter/folder_rule'
require 'inforouter/client'
require 'inforouter/configuration'
require 'inforouter/errors'
require 'inforouter/version'

module Inforouter
  class << self
    attr_accessor :configuration

    # Returns true if the gem has been configured.
    def configured?
      !!configured
    end

    # Configure the gem
    def configure
      self.configuration ||= Configuration.new
      yield configuration
    end

    def reset!
      self.configuration = nil
      @client = nil
    end

    def client
      check_configuration!
      @client ||= Inforouter::Client.new
    end

    private

    def check_configuration!
      fail Inforouter::Errors::MissingConfig.new unless self.configuration
      self.configuration.check!
    end
  end
end
