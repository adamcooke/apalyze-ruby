require 'apalyze/config'
require 'apalyze/event'

module Apalyze

  def self.config
    @config ||= Config.new
  end

  def self.configure(&block)
    block.call(self.config)
  end

  def self.track(name, &block)
    event = Event.new(name)
    block.call(event) if block_given?
    event.publish
    event
  end

end
