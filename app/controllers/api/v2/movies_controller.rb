module Api
  module V2
    class MoviesController < ::Api::ApplicationController

      def index
        render_response(Movie.includes(:genre).all)
      end

      def show
        render_response(Movie.includes(:genre).find(params[:id]))
      end

      private

      def render_response(result)
        render json: result, only: [:id, :title], include: {
          genre: {only: [:id, :name], methods: :number_of_movies}
        }
      end

    end
  end
end
