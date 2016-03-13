class FoodsController < ApplicationController
  def index
    @food = Food.all

    @total = @food.all.where(["created_at > ?", "2016-01-01 00:00:00"]).map{ |f| f.cost }.reduce(&:+)
  end

  def show
    @food = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    #binding.pry
    @food = Food.new(food_params)
    @food.save
    redirect_to @food
  end

  private

  def food_params
    params.require(:food).permit(:name, :cost)
  end
end
