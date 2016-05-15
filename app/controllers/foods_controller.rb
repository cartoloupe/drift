class FoodsController < ApplicationController
  include GenericHelper
  include FoodsHelper

  before_action :set_food, only: [:edit, :update, :destroy]
  before_action :get_foods, only: [:index, :show]

  def index
    @food = Food.all.latest.for_user(current_user_if_any)
  end

  def show
  end

  def new
    @food = current_user.foods.new
  end

  def edit
  end

  def trends
    set_trends
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to foods_path, notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @food = current_user.foods.new(validated_food_params)

    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @food.destroy
    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    def get_foods
      @food = Food.all.for_user(current_user_if_any)
    end

    def food_params
      params.require(:food).permit(:name, :cost, :created_at)
    end

    def validated_food_params
      food_params.tap do |food|
        food["cost"] = food["cost"].gsub("$", "")
      end
    end

    def set_trends
      @trends = Food.where("name like ?", "%#{food_params[:name]}%").latest.for_user(current_user_if_any)
    end
end
