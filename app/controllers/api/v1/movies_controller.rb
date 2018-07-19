module Api
  module V1
    class MoviesController < ::Api::ApplicationController

      def index
        render json: Movie.select(:id, :title)
      end

      def show
        render json: Movie.select(:id, :title).find(params[:id])
      end


    end
  end
end
