# Apalyze for Ruby

This library allows you to send events to Apalyze from Ruby.

## Installation

```ruby
gem 'apalyze', '~> 1.0'
```

## Usage

You should set the `APALYZE_APP_KEY` environment variable to an application's key. You can get this key from your Apalyze console. To submit events, you just need to use the simple method below. The data is sent via UDP and no reply is expected so the method is fast.

```ruby
# A very simple event (just logs occurances).
Apalyze.track('SomeEvent')

# A more complex tracking event which sends all the possible options.
Apalyze.track('Signup') do  |m|
  # Sets the time the event should be logged for
  event.time = user.created_at
  # If a message is provided, the event will be logged into your live feed
  event.message = "#{user.full_name} signed up to the #{user.package.name} package"
  # If an IP is provided, the user's location can be determined and plotted onto
  # the world view.
  event.ip_address = request.ip
  # Additional tags can be specified to allow you to filter & search for statisics
  # in the future. These must be strings or whole numbers only.
  event.tag :package, user.package.permalink
end
```

### Tracking IP addresses

As a shortcut, you can set `Thread.current[:apalyze_ip_address]` to the current IP of a request. Apalyze will use this variable if no `ip_address` is provided with your individual tracking events.

## Configuration

```ruby
Apalyze.configure do |c|

  # Sets the host that events are sent to. This is usually not needed if sending
  # to the Apalyze Cloud. These can also be set with APALYZE_HOST and APALYZE_PORT.
  c.host = "udp.apalyze.io"
  c.port = 13443

  # Sets the app key (also set from APALYZE_APP_KEY)
  c.app_key = "abcdefghi123456"

  # Sets the public key used for encryption. This can also be set with APALYZE_PUBLIC_KEY.
  c.public_key_text = File.read("path/to/public.key")

  # Sets whether messages should be sent asyncronously. If enabled, messages will be
  # sent in a thread. Enabled by default.
  c.async = false

  # Sets an error handler for any exceptions that are raised when delivery occurs
  # in an asyncronous thread
  c.error_handler do |exception|
    Raven.capture_exception(exception)
  end

  # Sets the logger to something other than STDOUT. Apalyze will log errors to STDOUt
  # unless a new logger is configured.
  c.logger = MyLogger.new

  # By default, only errors are logged. To log all data change the log level to
  # debug to receive everything.
  c.logger.level = Logger:DEBUG

end
```
