module GenericHelper
  def current_user_if_any
    if current_user
      current_user.id
    else
      User.where(email: 'guest_user@example.com').first.id
    end
  end

  def last_ten_days(date=Time.now, from=0)
    date = date + from.days
    20.times.map do |n|
      t = (date - n.days)
      [
        t.strftime('%Y-%m-%d %a'),
        t.strftime('%Y-%m-%d')
      ]
    end
  end

  def days_around_date(date)
    last_ten_days(date, 5)
  end

end
