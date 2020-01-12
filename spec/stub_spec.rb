require 'net/http'
require 'webmock/rspec'

class WeatherForStub

    attr_accessor :location

    def initialize(client = Net::HTTP)
        @uri = 'https://www.metaweather.com/api/location/search/?query='
        @client = client
        # WebMock.allow_net_connect! #WebMock defaults to blocking actual requests
    end

    def sendRequest
        @client.get(URI(@uri + self.location))
    end
end

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
        weatherAPI = WeatherForStub.new(StubClient.new)
        weatherAPI.location = 'sydney'
        response = weatherAPI.sendRequest
        expect(response.to_s).to include('woeid')
    end

end