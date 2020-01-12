require 'net/http'
require 'webmock/rspec'

class WeatherForDummy

    attr_accessor :location

    def initialize(client = Net::HTTP)
        @uri = 'https://www.metaweather.com/api/location/search/?query='
        @client = client
        WebMock.allow_net_connect! #WebMock defaults to blocking actual requests
    end

    def sendRequest
        @client.get(URI(@uri + self.location))
    end
end

class DummyClient
    def get(url)
        raise ("dummy client has been used")
    end
end

describe "APIConnection" do

    it "gets a response from the API" do
        weatherAPI = WeatherForDummy.new
        weatherAPI.location = 'london'
        response = weatherAPI.sendRequest
        expect(response).to include('London')

    end
end

describe "Dummy" do

    it "doesn't get any information" do
        weatherAPI = WeatherForDummy.new(DummyClient.new)
        weatherAPI.location = 'london'
        expect(weatherAPI).to have_attributes(:location => 'london')
    end

end