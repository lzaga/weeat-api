class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update, :destroy]

  def index
    render json: Restaurant.all
  end

  def show
    render json: @restaurant
  end

  def create
    begin
      @restaurant = Restaurant.create! restaurant_params
      render json: @restaurant, status: :created, location: @restaurant
    rescue => e
      Rails.logger.error e
      render json: 'Ops, the restaurant did not saved', status: :bad_request
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      Rails.logger.error @restaurant.errors
      render json: 'Ops, the restaurant did not updated', status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant.destroy
  end

  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :cuisine, :rating, :ten_bis, :address, :max_delivery_time)
    end
end
