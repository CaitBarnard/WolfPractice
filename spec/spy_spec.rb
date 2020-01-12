require 'net/http'
require 'weather'

class SpyClient
    def get(url)
        data = [{
                "title":"Tokyo",
                "location_type":"City",
                "woeid":1118370,
                "latt_long":"35.670479,139.740921"
            }]
    end
end

describe "Spy" do

    it "tells if get method was called" do
        client = SpyClient.new
        weatherAPI = Weather.new(client)
        weatherAPI.location = 'tokyo'

        expect(client).to receive(:get).once

        response = weatherAPI.sendRequest
    end
end