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

end
