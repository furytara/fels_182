class Activity < ActiveRecord::Base
  belongs_to :user
  scope :desc_date, -> {order(created_at: :desc)}
  validates :user, presence: true
  enum action_type: [:follow, :unfollow, :create_lesson, :update_lesson]
end
