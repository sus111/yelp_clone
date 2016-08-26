require 'rails_helper'
require 'spec_helper'

describe Restaurant, type: :model do

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end
  end

  context 'multiple reviews' do
  it 'returns the average' do
    restaurant = Restaurant.create(name: 'The Ivy')
    restaurant.save(validate: false)
    restaurant.reviews.create(rating: 1).save(validate: false)
    restaurant.reviews.create(rating: 5).save(validate: false)
    expect(restaurant.average_rating).to eq 3
  end
end

  describe 'reviews' do
    describe 'build_with_user' do

      let(:user) { User.create email: 'test@test.com' }
      let(:restaurant) { Restaurant.create name: 'Test' }
      let(:review_params) { {rating: 5, thoughts: 'yum'} }

      subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

        it 'builds a review' do
          expect(review).to be_a Review
        end

        it 'builds a review associated with the specified user' do
          expect(review.user).to eq user
        end
    end
  end

end
