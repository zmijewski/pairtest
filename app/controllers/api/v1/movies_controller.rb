module Api

  module V1

    class MoviesController < ActionController::API
      def index
        render json: Movie.select(:id, :title)
      end
    end

  end

end