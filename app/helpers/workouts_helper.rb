module WorkoutsHelper
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
