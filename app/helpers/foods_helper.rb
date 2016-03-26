module FoodsHelper
  def current_user_if_any
    if current_user
      current_user.id
    else
      User.where(email: 'guest_user@example.com').first.id
    end
  end

  def all
    Food.all
  end

  def total
    all.for_user(current_user_if_any).map{ |f| f.cost }.reduce(&:+)
  end

  def last_n_with_offset(n, offset)
    all.for_user(current_user_if_any).last_n_days_with_offset(n, offset).map{ |f| f.cost }.reduce(&:+)
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
