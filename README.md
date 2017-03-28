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
  event.tags[:package] = user.package.name
end
```
