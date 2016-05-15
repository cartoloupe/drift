class Workout < ActiveRecord::Base
  scope :latest,
    -> {
      order(created_at: :desc)
    }

  scope :for_user,
    -> (user_id) {
      where(user_id: user_id)
    }

end
