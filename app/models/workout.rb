class Workout < ActiveRecord::Base
  scope :latest, -> {
    order(created_at: :desc)
  }
end
