class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed? @restaurant
      flash[:notice] = "Duh! You've already reviewed this restaurant!"
      redirect_to "/restaurants"
    else
    @review = Review.new
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review review_params, current_user
    if @review.save
      redirect_to "/restaurants"
    else
      if @review.errors[:user]
        redirect_to restaurants_path, alert: "Duh! You've already reviewed this restaurant!"
      else
        render "new"
      end
    end
  end

  # def create
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   @review = @restaurant.reviews.new(review_params)
  #   @review.user = current_user
  #   if @review.save
  #     redirect_to "/restaurants"
  #   else
  #     render "new"
  #   end
  # end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
