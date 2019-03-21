class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  before_action :set_comment, only: [:show, :destroy_comment]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments
  end

  def create_comment
    @comment =  Comment.new(comment_params)
    if @comment.save!
      flash[:notice] = "Comment has been created successful"
      redirect_to movie_path(params[:id])
    end
  end

  def destroy_comment
    flash[:notice] = "Comment has been detroyed successful" if @comment.destroy!
    redirect_to movie_path(params[:id])
 end


  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

  private
  def set_comment
    @comment = Comment.where("movie_id = ?", params[:id]).find_by(user_id: current_user.id) if current_user
    @comment = Comment.new unless @comment
  end

  def comment_params
    params.require(:comment).permit(:text, :movie_id, :user_id)
  end
end
