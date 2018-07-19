module Api
  class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found
      render json: '{"error": "not_found"}', status: 404
    end

  end
end
