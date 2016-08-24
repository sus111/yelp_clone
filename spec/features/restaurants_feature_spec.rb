require "rails_helper"

feature "restaurants" do
  context "no restaurants have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content "No restaurants yet"
    end
  end

  context "viewing restaurants" do
    let!(:kfc) { Restaurant.create(name: "KFC") }

    scenario "lets a user view a restaurant" do
      visit "/restaurants"
      click_link "KFC"
      expect(page).to have_content "KFC"
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context "user not signed in" do
    scenario "cannot add new restaurant" do
      visit "/restaurants"
      expect(page).not_to have_link "Add a restaurant"
    end

    scenario "cannot edit a restaurant" do
      visit "/restaurants"
      expect(page).not_to have_link "Edit KFC"
    end

    scenario "cannot delete a restaurant" do
      visit "/restaurants"
      expect(page).not_to have_link "Delete KFC"
    end

    scenario "cannot review a restaurant" do
      visit '/restaurants'
      expect(page).not_to have_link "Review KFC"
    end
  end

  context "user has singed in" do
    before do
      sign_up
    end

    context "restaurants have been added" do
      before do
        Restaurant.create(name: "KFC")
      end

      scenario "display restaurants" do
        visit "/restaurants"
        expect(page).to have_content "KFC"
        expect(page).not_to have_content "No restaurants yet"
      end
    end

    context "creating restaurants" do
      scenario "prompts user to fill out a form, then displays the new restaurant" do
        visit "/restaurants"
        click_link "Add a restaurant"
        fill_in "Name", with: "KFC"
        click_button "Create Restaurant"
        expect(page).to have_content "KFC"
        expect(current_path).to eq "/restaurants"
      end
    end

    context "editing restaurants" do
      let!(:kfc) { Restaurant.create(name: "KFC", description: "Deep fried goodness") }

      scenario "lets a user edit a restaurant" do
        visit "/restaurants"
        click_link "Edit KFC"
        fill_in "Name", with: "Kentucky Fried Chicken"
        fill_in "Description", with: "Deep fried goodness"
        click_button "Update Restaurant"
        click_link "Kentucky Fried Chicken"
        expect(page).to have_content "Kentucky Fried Chicken"
        expect(page).to have_content "Deep fried goodness"
        expect(current_path).to eq "/restaurants/#{kfc.id}"
      end
    end

    context "deleting restaurants" do
      before do
        Restaurant.create(name: "KFC", description: "Deep fried goodness")
      end

      scenario "removes a restaurant when delete link is clicked" do
        visit "/restaurants"
        click_link "Delete KFC"
        expect(page).not_to have_content "KFC"
        expect(page).to have_content "Restaurant deleted successfully"
      end
    end

    context "entering invalid restaurant name" do
      it "does not let you enter a name that is too short" do
        visit "/restaurants"
        click_link "Add a restaurant"
        fill_in "Name", with: "kf"
        click_button "Create Restaurant"
        expect(page).not_to have_css "h3", text: "kf"
        expect(page).to have_content "error"
      end
    end

  end

end
