module Api
  module V1
    class MoviesController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def index
        render json: Movie.select(:id, :title)
      end

      def show
        render json: Movie.select(:id, :title).find(params[:id])
      end

      private

      def not_found
        render json: '{"error": "not_found"}', status: 404
      end
    end
  end
end
