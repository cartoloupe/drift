class AddOtherTrackersToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :reps, :integer
    add_column :workouts, :sets, :integer
    add_column :workouts, :weight, :decimal
  end
end
