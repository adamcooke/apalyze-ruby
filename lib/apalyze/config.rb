require 'openssl'
require 'logger'

module Apalyze
  class Config

    attr_accessor :host
    attr_accessor :port
    attr_accessor :public_key
    attr_accessor :app_key
    attr_accessor :async
    attr_reader :error_handler
    attr_accessor :logger

    def host
      @host || ENV['APALYZE_HOST'] || "udp.apalyze.io"
    end

    def port
      (@port || ENV['APALYZE_PORT'] || 13443).to_i
    end

    def public_key_text
      @public_key_text ||= ENV['APALYZE_PUBLIC_KEY'] || File.read(File.expand_path('../../../udp.key', __FILE__))
    end

    def public_key
      @public_key ||= OpenSSL::PKey::RSA.new(self.public_key_text)
    end

    def app_key
      @app_key || ENV['APALYZE_APP_KEY']
    end

    def error_handler(&block)
      block_given? ? @error_handler = block : @error_handler
    end

    def logger
      @logger ||= begin
        l = Logger.new(STDOUT)
        l.level = :info
        l
      end
    end

    def async?
      @async != false
    end

    def ready?
      !!app_key
    end

  end
end
