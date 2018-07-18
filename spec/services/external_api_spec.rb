require "rails_helper"

describe "External requests" do

  describe "movie" do
    before(:all) do
      @host_url = "http://example.com"
      @consumer = ExternalAPI::MovieConsumer.new(@host_url, {})

      @body = '{
        "data":
          {"attributes":
            {
             "plot": "a plot of a movie",
             "rating": 8.8,
             "poster": "/poster.jpg"
            }
         }
      }'

      @body_with_missing_attributes = '{
        "data":
          {"attributes":
            {
             "rating": 8.8,
             "poster": "/poster.jpg"
            }
         }
      }'

      @movie_template = Addressable::Template.new "#{@host_url}/api/v1/movies/{title}"
    end

    it "replaces ASCII spaces in title with UTF-8 encoding" do
      stub = stub_request(:get, @movie_template)

      @consumer.movie(Faker::Lorem.sentence(3))

      expect(stub).to have_been_requested
    end

    it "results with plot on success" do
      stub_request(:get, @movie_template).to_return(body: @body)

      result = @consumer.movie(Faker::Lorem.word)

      expect(result[:plot]).to eq("a plot of a movie")
    end

    it "results with rating on success" do
      stub_request(:get, @movie_template).to_return(body: @body)

      result = @consumer.movie(Faker::Lorem.word)

      expect(result[:rating]).to eq(8.8)
    end

    it "results with cover on success" do
      stub_request(:get, @movie_template).to_return(body: @body)

      result = @consumer.movie(Faker::Lorem.word)

      expect(result[:cover]).to eq("#{@host_url}/poster.jpg")
    end

    it "results with empty hash on failure" do
      stub_request(:get, @movie_template).to_return(status: 404)

      result = @consumer.movie(Faker::Lorem.word)

      expect(result).to eq({})
    end

    it "results with missing plot when API is changed" do
      stub_request(:get, @movie_template)
        .to_return(body: @body_with_missing_attributes)

      result = @consumer.movie(Faker::Lorem.word)

      expect(result[:plot]).to eq(nil)
      expect(result[:rating]).to_not eq(nil)
      expect(result[:cover]).to_not eq(nil)
    end

  end

end
