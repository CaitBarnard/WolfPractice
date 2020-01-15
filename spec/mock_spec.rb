require 'net/http'
require 'weather'

class MockClient

    attr_accessor :get_is_called

    def initialize
        @get_is_called = false
    end

    def get(url)
        @get_is_called = true
    end

    def verifyGet(test)
        test.expect(get_is_called).to test.eq(true)
    end
end

describe 'Mock' do

    it "verifies that it got something" do
        client = MockClient.new

        weatherAPI = Weather.new(client)
        weatherAPI.location = 'barcelona'

        response = weatherAPI.sendRequest
        client.verifyGet(self)
    end

end