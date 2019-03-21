module CommentHelper
  def time_ago comment
    time_ago_in_words(comment.created_at) + " ago"
  end

  def user_has_no_comments?
    user_signed_in? && current_user.comments.where(movie_id: params[:id]).count < 1
  end

  def user_comment? comment
    user_signed_in? && current_user == comment.user
  end
end