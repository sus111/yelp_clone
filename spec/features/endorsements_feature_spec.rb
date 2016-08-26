require 'rails_helper'

feature 'endorsing reviews' do
  before do
    sign_up
    add_restaurant
    leave_review("tasty", 4)
  end

  it 'a user can endorse a review, which increments the endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content("1 endorsement")
  end
end
