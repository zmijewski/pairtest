class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id]).decorate
  end

  def send_info
    MailerJob.perform_later(current_user.id, params[:id])
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    ExportJob.perform_later(current_user.id, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end
