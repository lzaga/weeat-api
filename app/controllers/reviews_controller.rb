class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :update, :destroy]

  def index
    @reviews = Review.all

    render json: @reviews
  end

  def show
    render json: @review
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      render json: @review, status: :created, location: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def update
    if params[:rating]
      prev_rating = @review.rating
      new_rating = params[:rating]
      @review.update_average_rating_on_restaurant(prev_rating, new_rating)
    end

    if @review.update(review_params)
      render json: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.permit(:restaurant_id, :reviewer, :review, :rating)
    end
end
