require 'net/http'
require 'weather'


class DummyClient
    def get(url)
        raise ("dummy client has been used")
    end
end

describe "APIConnection" do

    it "gets a response from the API" do
        weatherAPI = Weather.new
        weatherAPI.location = 'london'
        response = weatherAPI.sendRequest
        expect(response).to include('London')

    end
end

describe "Dummy" do

    it "doesn't get any information" do
        weatherAPI = Weather.new(DummyClient.new)
        weatherAPI.location = 'london'
        expect(weatherAPI).to have_attributes(:location => 'london')
    end

end