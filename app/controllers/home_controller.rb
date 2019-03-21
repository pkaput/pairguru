class HomeController < ApplicationController
  def welcome; end

  def ranking
    @users = Comment.where("created_at > ?", 1.week.ago)
                    .group(:user)
                    .order("count_all desc")
                    .limit(10)
                    .count
  end
end
