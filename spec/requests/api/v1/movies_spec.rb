require "rails_helper"

describe "Movies requests API v1", type: :request do
  let!(:genres) { create_list(:genre, 1, :with_movie) }

  describe "movies list" do
    it "display ids and titles only" do
      visit "/api/v1/movies"

      parsed_body = JSON.parse(body)
      expect(parsed_body.first.keys.length).to eq(2)
      expect(parsed_body.first.keys).to include("id", "title")
    end
  end

  describe "movie show" do
    it "displays ids and titles only for particular movie ID" do
      visit "/api/v1/movies/1"

      parsed_body = JSON.parse(body)
      expect(parsed_body.keys.length).to eq(2)
      expect(parsed_body.keys).to include("id", "title")
    end

    it "displays 404 when movie cannot be found" do
      visit "/api/v1/movies/2"

      expect(status_code).to eq(404)
    end
  end

end
