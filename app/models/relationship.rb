class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  validates :follower, presence: true
  validates :followed, presence: true

  private
  def create_follow_activity
    Activity.create user_id: follower_id, target_id: followed_id,
      action_type: :follow
  end

  def create_unfollow_activity
    Activity.create user_id: follower_id, target_id: followed_id,
      action_type: :unfollow
  end
end
