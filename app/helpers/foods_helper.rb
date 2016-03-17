module FoodsHelper
  def total
    Food.all.for_user(current_user.id).map{ |f| f.cost }.reduce(&:+)
  end

  def last_n_with_offset(n, offset)
    Food.all.for_user(current_user.id).last_n_days_with_offset(n, offset).map{ |f| f.cost }.reduce(&:+)
  end

  def this_month
    last_n_with_offset(30,0)
  end

  def last_month
    last_n_with_offset(30,30)
  end

  def this_week
    last_n_with_offset(7,0)
  end

  def last_week
    last_n_with_offset(7,7)
  end

end
