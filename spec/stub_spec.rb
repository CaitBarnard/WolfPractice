require 'net/http'
require 'webmock/rspec'
require 'weather'

class StubClient
    def get(url)
        [{"title":"Colorado Springs",
        "location_type":"City",
        "woeid":2383489,
        "latt_long":"38.833450,-104.821808"
        }]
    end
end

describe "Stub" do

    it "always returns the same response" do
        weatherAPI = Weather.new(StubClient.new)
        weatherAPI.location = 'colorado'
        response = weatherAPI.sendRequest
        expect(response.to_s).to include('woeid')
    end

end