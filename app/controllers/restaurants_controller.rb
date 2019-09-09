class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update, :destroy]

  def index
    params = ActionController::Parameters.new(request.query_parameters)
    permitted_params = params.permit(:rating, :cuisine, :max_delivery_time)

    if permitted_params.permitted?
      @restaurants = Restaurant.where(converted_params(permitted_params))
    else
      @restaurants = Restaurant.all
    end

    render json: @restaurants
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

  def converted_params(query_params)
    query_params[:rating] = ((query_params[:rating].to_i)..Restaurant::MAX_RATING) if query_params[:rating].present?

    query_params[:cuisine] = (query_params[:cuisine]) if query_params[:cuisine].present?

    query_params[:max_delivery_time] = (0..(query_params[:max_delivery_time].to_i)) if query_params[:max_delivery_time].present?

    query_params
  end
end
