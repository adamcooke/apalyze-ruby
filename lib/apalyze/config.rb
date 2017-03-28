require 'openssl'

module Apalyze
  class Config

    attr_accessor :host
    attr_accessor :port
    attr_accessor :public_key
    attr_accessor :app_key

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

  end
end
