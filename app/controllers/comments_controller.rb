class CommentsController < ApplicationController
  include CommentsHelper
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def new
    @comment = Comment.new(movie_id: params[:movie_id])
  end

  def create
    @movie = Movie.find(params[:comment][:movie_id])

    if can_user_comment_movie?(current_user, @movie)
      @comment = Comment.new(comment_params.merge(user_id: current_user.id))
      if @comment.save
        flash[:notice] = "Comment added"
      else
        flash[:error] = "Something went wrong"
      end
    end
    redirect_to @movie
  end

  def destroy
    if Comment.find(params[:id]).destroy
      flash[:notice] = "Comment deleted"
    else
      flash[:error] = "Something went wrong"
    end

    redirect_back fallback_location: root_path
  end

  def top_commenters
    @commenters = User.top_commenters_from_last_week
  end

  def comment_params
    params.require(:comment).permit(:content, :movie_id)
  end
end
