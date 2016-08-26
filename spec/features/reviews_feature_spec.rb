require "rails_helper"

feature "reviewing" do
  before do
    sign_up
    add_restaurant
  end

  scenario "can see review a restaurant" do
    visit "/restaurants"
    expect(page).to have_link "Review KFC"
  end

  scenario "allows users to enter a restaurant review" do
    leave_review('So so', '3')
    expect(current_path).to eq "/restaurants"
    expect(page).to have_content "So so"
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('so so', '3')
    click_link "Sign out"
    sign_up(user: "dan@example.com", password: "daniel")
    leave_review('Great!', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end

end
