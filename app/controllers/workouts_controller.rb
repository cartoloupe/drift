class WorkoutsController < ApplicationController
  include GenericHelper
  include WorkoutsHelper

  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :trends

  # GET /workouts
  # GET /workouts.json
  def index
    @workouts = Workout.all.latest.for_user(current_user_if_any)
    @trends = @workouts.to_a.uniq(&:name)
    @trend_list = @trends.map(&:name).uniq
  end

  # GET /workouts/1
  # GET /workouts/1.json
  def show
  end

  # GET /workouts/:name
  def trends
    set_trends
    respond_to do |format|
      format.js
    end
  end

  # GET /workouts/new
  def new
    @workout = Workout.new
  end

  # GET /workouts/1/edit
  def edit
  end

  # POST /workouts
  # POST /workouts.json
  def create
    @workout = current_user.workouts.new(workout_params)

    respond_to do |format|
      if @workout.save
        format.html { redirect_to workouts_path, notice: 'Workout was successfully created.' }
        format.json { render :show, status: :created, location: @workout }
      else
        format.html { render :new }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workouts/1
  # PATCH/PUT /workouts/1.json
  def update
    respond_to do |format|
      if @workout.update(workout_params)
        format.html { redirect_to workouts_path, notice: 'Workout was successfully updated.' }
        format.json { render :show, status: :ok, location: @workout }
      else
        format.html { render :edit }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.json
  def destroy
    @workout.destroy
    respond_to do |format|
      format.html { redirect_to workouts_url, notice: 'Workout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = Workout.find(params[:id])
    end

    def set_trends
      @trends = Workout
        .for_user(current_user_if_any)
        .where(name: params[:name].gsub("_", " "))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_params
      params.require(:workout).permit(:name, :duration, :reps, :sets, :weight, :notes, :created_at)
    end
end
