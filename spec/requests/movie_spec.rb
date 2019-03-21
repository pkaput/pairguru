require "rails_helper"

describe "Movie requests", type: :request do
  let!(:movie) { create(:movie) }

  describe "movie/:id" do
    before { visit "/movies/#{movie.id}" }
    it "displays movie title" do
      expect(page).to have_selector('h1', text: movie.title)  
    end

    it "displays movie description" do
      expect(page).to have_selector('div.jumbotron', text: movie.description)  
    end
  end
end