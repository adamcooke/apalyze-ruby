require 'base64'
require 'json'
require 'socket'

module Apalyze
  class Event

    attr_accessor :time
    attr_accessor :message
    attr_accessor :ip_address

    def initialize(name)
      @name = name
      @time = Time.now
      @tags = {}
    end

    def publish
      if Apalyze.config.ready?
        self.class.socket.send(encrypted_payload, 0, Apalyze.config.host, Apalyze.config.port)
      else
        # Not sending because we don't have a key.
      end
    end

    def tag(name, value = nil)
      @tags[name.to_s] = value.to_s.gsub(/[^A-Za-z0-9\_\.]/, '')
    end

    def payload
      hash = {}
      hash[:sent_at] = Time.now.to_i
      hash[:event] = @name
      hash[:app_key] = Apalyze.config.app_key
      hash[:time] = @time.to_f
      hash[:message] = @message if @message
      hash[:tags] = @tags unless @tags.empty?
      hash
    end

    def encrypted_payload
      aes_encrypt = OpenSSL::Cipher::Cipher.new('AES-256-CBC').encrypt
      aes_encrypt.key = aes_key = Random.new.bytes(32)
      crypt = aes_encrypt.update(payload.to_json) << aes_encrypt.final
      encrypted_key = Apalyze.config.public_key.public_encrypt(aes_key)
      Base64.encode64([encrypted_key.bytesize, encrypted_key, crypt].pack("na*a*"))
    end

    def self.socket
      @socket ||= UDPSocket.new
    end

  end
end
