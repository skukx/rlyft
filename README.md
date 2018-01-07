# RLyft
[![Gem Version](https://badge.fury.io/rb/rlyft.svg)](https://badge.fury.io/rb/rlyft)
[![CircleCI](https://circleci.com/gh/skukx/rlyft.svg?style=shield)](https://circleci.com/gh/skukx/rlyft)

Simple wrapper for interacting with Lyft's public api.

## Breaking Changes
  See https://github.com/skukx/rlyft/pull/6

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rlyft', require 'lyft'
```

And then execute:

    $ bundle

## Setup

```ruby
client = Lyft::Client.new(
  client_id: 'client_id',
  client_secret: 'client_secret',
  use_sandbox: true
)
```

## Using Public Api
Get Access Token:

```ruby
# Public token
client.oauth.retrieve_access_token

# When using oauth.
client.oauth.retrieve_access_token authorization_code: 'auth_code'
```

Calculate Lyft cost.

```ruby
client.availability.cost access_token: 'access_token',
                         params: {
                           start_lat: 37.7772,
                           start_lng: -122.4233,
                           end_lat: 37.7972,
                           end_lng: -122.4533
                         }
```

Time for nearest driver to reach location.

```ruby
client.availability.eta access_token: 'token',
                        params: {
                          lat: 37.7772,
                          lng: -122.4233
                        }
```

Get the location of nearby drivers.

```ruby
client.availability.nearby_drivers access_token: 'token',
                                   params: {
                                     lat: 37.7772,
                                     lng: -122.4233
                                   }
```

Get available ride types.

```ruby
client.availability.ride_types access_token: 'token',
                               params: {
                                 lat: 37.7772,
                                 lng: -122.4233
                               }
```

Request a ride
```ruby
client.rides.request access_token: 'token',
                     params: {
                       origin: { lat: 37.7772, lng: -122.4233 },
                       ride_type: Lyft::Ride::Type::LYFT
                     }
```

Cancel a ride
```ruby
client.rides.cancel access_token: 'token',
                    params: { ride_id: '123' }

# When cancel_confirmation_token is needed.
client.rides.cancel access_token: 'token',
                    params: {
                      ride_id: '123',
                      cancel_confirmation_token: 'cancellation_token'
                    }
```

## Using the Sandbox:

Set available ride types
```ruby
client.rides.set_ridetypes(
  access_token: 'my_token',
  params: {
    lat: 37.7833,
    lng: -122.4167,
    ride_types: [
      Lyft::Ride::Type::LYFT,
      Lyft::Ride::Type::LYFT_PLUS
    ]
  }
)
```

Set ride status
```ruby
client.rides.set_status(
  access_token: 'my_token',
  params: {
    ride_id: 'my_ride_id',
    status: Lyft::Ride::Status::ACCEPTED
  }
)
```

Set driver availability
```ruby
client.rides.set_driver_availability(
  access_token: 'my_token',
  params: {
    ride_type: Lyft::Ride::Type::LYFT_SUV
    lat: 37.7833,
    lng: -122.4167,
    driver_availability: true
  }
)
```

Set primetime percentage
```ruby
client.rides.set_primetime(
  access_token: 'my_token',
  params: {
    lat: 37.7833,
    lng: -122.4167,
    primetime_percentage: '25%'
  }
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/skukx/lyft.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
