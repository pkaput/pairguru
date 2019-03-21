require "rails_helper"

describe "Top commenters requests", type: :request do
  let!(:users) { create_list(:user, 10, :with_random_number_of_comments) }

  describe "/top_commenters" do
    before { visit "/top_commenters" }

    context 'when number of user fits to size of ranking' do
      it "displays top users" do
        users.each do |user|
          expect(page).to have_selector('td', text: user.name) 
        end
      end

      it "displays number of wrriten comments" do
        users.each do |user|
          expect(page).to have_selector('td', text: user.comments.count) 
        end
      end
    end

    context 'when number of user is bigger than ranking' do
      let!(:users) { create_list(:user, 20, :with_random_number_of_comments) }
      it "displays no more than 10 users" do
        expect(page).to have_selector('tr', count: 11)
      end
    end
  end
end