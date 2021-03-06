class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user, counter_cache: :followings_count
  belongs_to :following, class_name: "User", counter_cache: :followings_count

end
