class Food < ActiveRecord::Base
  scope :last_thirty, -> {
    where(["created_at > ?", Time.now - 30.days])
  }
  scope :last_week, -> {
    where(["created_at > ?", Time.now - 7.days])
  }
  scope :last_n_days, -> (n_days) {
    where(["created_at > ?", Time.now - n_days.days])
  }
  scope :last_n_days_with_offset,
    -> (n_days, offset) {
      where(
        ["created_at > ?", Time.now - (n_days + offset).days]
      ).
      where(
        ["created_at < ?", Time.now - offset.days]
      )
    }

end
