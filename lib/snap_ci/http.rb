require 'faraday'

module SnapCi
  class Http
    URL = 'https://api.snap-ci.com'

    def initialize(config)
      @http = Faraday.new(url: URL) do |conection|
        conection.basic_auth(config.user, config.token)
        conection.headers['Content-Type'] = 'text/plain'
        conection.headers['Accept'] = 'application/vnd.snap-ci.com.v1+json'
        conection.adapter Faraday.default_adapter
      end
    end

    def get(parameters = '')
      @http.get(parameters)
    end
  end
end
