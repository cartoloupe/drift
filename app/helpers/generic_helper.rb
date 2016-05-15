module GenericHelper
  def current_user_if_any
    if current_user
      current_user.id
    else
      User.where(email: 'guest_user@example.com').first.id
    end
  end

  def last_ten_days
    10.times.map do |n|
      t = (Time.now - n.days)
      [
        t.strftime('%Y-%m-%d %a'),
        t.strftime('%Y-%m-%d')
      ]
    end
  end
end
