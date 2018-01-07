def stub_get(path, endpoint = Lyft::Client::Api::BASE_URL)
  stub_request(:get, endpoint + path)
end

def stub_post(path, endpoint = Lyft::Client::Api::BASE_URL)
  stub_request(:post, endpoint + path)
end

def stub_patch(path, endpoint = Lyft::Client::Api::BASE_URL)
  stub_request(:patch, endpoint + path)
end

def stub_put(path, endpoint = Lyft::Client::Api::BASE_URL)
  stub_request(:put, endpoint + path)
end

def stub_delete(path, endpoint = Lyft::Client::Api::BASE_URL)
  stub_request(:delete, endpoint + path)
end
