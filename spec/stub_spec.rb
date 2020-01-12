require 'net/http'
require 'webmock/rspec'
require 'weather'

class StubClient
    def get(url)
        [{
            "title":"Sydney",
            "location_type":"City",
            "woeid":1105779,
            "latt_long":"-33.869629, 151.206955"
        }]
    end
end

describe "Stub" do

    it "always returns the same response" do
        weatherAPI = Weather.new(StubClient.new)
        weatherAPI.location = 'sydney'
        response = weatherAPI.sendRequest
        expect(response.to_s).to include('woeid')
    end

end