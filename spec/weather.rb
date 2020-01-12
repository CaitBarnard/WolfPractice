class Weather

    attr_accessor :location

    def initialize(client = Net::HTTP)
        @uri = 'https://www.metaweather.com/api/location/search/?query='
        @client = client
        WebMock.allow_net_connect! #WebMock defaults to blocking actual requests
    end

    def sendRequest
        @client.get(URI(@uri + self.location))
    end

    def update(newData)
        response = @client.put(URI(@uri + self.location), newData)
    end
end