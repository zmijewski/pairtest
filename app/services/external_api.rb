
module ExternalAPI

  class ConnectionFactory

    def self.create(host_url, options = {})
      Faraday.new(url: host_url) do |builder|
        builder.response :json

        if options[:cache]
          builder.use FaradayMiddleware::Caching do
            cache_dir = File.join(ENV['TMPDIR'] || Dir.pwd + "/tmp", "cache/api")
            ActiveSupport::Cache::FileStore.new cache_dir, expires_in: 3600 # one hour
          end
        end

        builder.adapter :typhoeus
      end
    end
  end

  class MovieConsumer

    def initialize(url = "https://pairguru-api.herokuapp.com", options = {cache: true})
      @host_url = url
      @connection = ConnectionFactory.create(@host_url, options)
    end

    def movie(title)
      encoded_title = simple_encode(title)
      response = @connection.get "/api/v1/movies/#{encoded_title}"

      if response.success?
        { plot: plot(response),
          rating: rating(response),
          cover: cover(response)}
      else
        {}
      end
    end

    private

    def plot(response)
      response.body["data"]["attributes"]["plot"] if response.body
    end

    def rating(response)
      response.body["data"]["attributes"]["rating"] if response.body
    end

    def cover(response)
      @host_url + response.body["data"]["attributes"]["poster"] if response.body
    end

    def simple_encode(text)
      text.gsub(" ", "%20")
    end

  end

end