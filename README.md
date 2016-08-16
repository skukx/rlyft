# RLyft
[![Gem Version](https://badge.fury.io/rb/rlyft.svg)](https://badge.fury.io/rb/rlyft)

Simple wrapper for interacting with Lyft's public api.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rlyft'
```

And then execute:

    $ bundle

## Setup

```ruby
client = Lyft::Client.new do |c|
  c.client_id = 'client_id'
  c.client_secret = 'client_secret'
end
```

## Using Public Api
Calculate Lyft cost.

```ruby
client.cost start_lat: 37.7772,
            start_lng: -122.4233,
            end_lat: 37.7972,
            end_lng: -122.4533
```

Time for nearest driver to reach location.

```ruby
client.eta lat: 37.7772,
           lng: -122.4233
```

Get the location of nearby drivers.

```ruby
client.nearby_drivers lat: 37.7772,
                      lng: -122.4233
```

Get available ride types.

```ruby
client.ride_types lat: 37.7772,
                  lng: -122.4233
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/skukx/lyft.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
