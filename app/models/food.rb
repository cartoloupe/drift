class Food < ActiveRecord::Base
  scope :last_thirty, -> {
    where(["created_at > ?", Time.now - 30.days])
  }
  scope :last_week, -> {
    where(["created_at > ?", Time.now - 7.days])
  }
end
