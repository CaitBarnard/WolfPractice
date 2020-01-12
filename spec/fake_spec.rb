require 'net/http'
require 'weather'

class FakeClient

    attr_accessor :data

    def initialize
        self.data = [{
            "title":"Sydney",
            "location_type":"City",
            "woeid":1105779,
            "latt_long":"-33.869629, 151.206955"
        }]
    end

    def get(url)
        return self.data
    end

    def put(url, params)
        self.data = {**params}
        self.get(url)
    end
    
end

describe "Fake" do

    it "doesn't have a database but looks like it does" do
        weatherAPI = Weather.new(FakeClient.new)
        weatherAPI.location = 'sydney'
        response = weatherAPI.sendRequest
        expect(response.to_s).to include('woeid')
        expect(response.to_s).to include('1105779')

        weatherAPI.update({**response[0], woeid: 1234567})
        updatedResponse = weatherAPI.sendRequest

        expect(updatedResponse.to_s).to include('woeid')
        expect(updatedResponse.to_s).to include('1234567')
    end

end