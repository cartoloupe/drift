class Food < ActiveRecord::Base
  scope :latest, -> {
    order(created_at: :desc)
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
  scope :for_user,
    -> (user_id) {
      where(user_id: user_id)
    }

  def self.this_week
    self.last_n_days_with_offset(7,0).map{|f|f.cost}.reduce(&:+)
  end

  def self.last_week
    self.last_n_days_with_offset(7,7).map{|f|f.cost}.reduce(&:+)
  end

  def self.this_month
    self.last_n_days_with_offset(30,0).map{|f|f.cost}.reduce(&:+)
  end

  def self.last_month
    self.last_n_days_with_offset(30,30).map{|f|f.cost}.reduce(&:+)
  end

  def self.total
    self.all.map{|f|f.cost}.reduce(&:+)
  end
end
