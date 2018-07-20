module CommentsHelper
  def can_user_comment_movie?(user, movie)
    movie.comments.where(user_id: user.id).first.nil?
  end
end