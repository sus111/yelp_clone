class EndorsementsController < ApplicationController

  before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    render json: {new_endorsement_count: @review.endorsements.count}
    # redirect_to '/restaurants'
  end

end
