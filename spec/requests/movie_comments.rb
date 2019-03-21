require "rails_helper"

describe "Movie Comments requests", type: :request do
  let!(:movie) { create(:movie, :with_comments) }
  let(:comments) { movie.comments }

  describe "movie/:id comments" do
    before { visit "/movies/#{movie.id}" }
    it "displays all comments" do
      comments.each do |comment|
        expect(page).to have_selector('li.list-group-item p big', text: comment.text) 
      end
    end
  end
end