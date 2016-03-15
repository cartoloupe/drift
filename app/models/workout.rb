class Workout < ActiveRecord::Base
  scope :latest, -> {
    order(created_at: :desc)
  }
  scope :push_press, -> {
    where(name: "Push press")
  }
end
