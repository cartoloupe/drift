class Workout < ActiveRecord::Base
  scope :push_press, -> {
    where(name: "Push press")
  }
end
