module Lyft
  class Client
    module Api
      VERSION = ENV['LYFT_API_VERSION'] || 'v1'
      BASE_URL = 'https://api.lyft.com'
    end
  end
end
