module FoodsHelper
  def total
    Food.all.last_thirty.map{ |f| f.cost }.reduce(&:+)
  end

  def last_week
    Food.all.last_week.map{ |f| f.cost }.reduce(&:+)
  end

  def last_n(n)
    Food.all.last_n_days(n).map{ |f| f.cost }.reduce(&:+)
  end

  def last_n_with_offset(n, offset)
    Food.all.last_n_days_with_offset(n, offset).map{ |f| f.cost }.reduce(&:+)
  end
end
