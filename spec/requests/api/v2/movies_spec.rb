require "rails_helper"

describe "Movies requests API v2", type: :request do
  let!(:genres) { create_list(:genre, 1, :with_movie) }

  describe "movies list" do
    it "display ids, titles and genre with details only" do
      visit "/api/v2/movies"

      parsed_body = JSON.parse(body)

      expect(parsed_body.first.keys.length).to eq(3)
      expect(parsed_body.first.keys).to include("id", "title", "genre")
      expect(parsed_body.first["genre"].keys).to include("id", "name", "number_of_movies")
    end
  end

  describe "movie show" do
    it "displays ids, titles and genre with details only for particular movie ID" do
      visit "/api/v2/movies/1"

      parsed_body = JSON.parse(body)
      expect(parsed_body.keys.length).to eq(3)
      expect(parsed_body.keys).to include("id", "title", "genre")
      expect(parsed_body["genre"].keys).to include("id", "name", "number_of_movies")
    end

    it "displays 404 when movie cannot be found" do
      visit "/api/v2/movies/2"

      expect(status_code).to eq(404)
    end
  end

end
