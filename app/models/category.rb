class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessons
  scope :update_desc, -> {order(updated_at: :desc)}
  validates :name, presence: true, length: {maximum: 140}
end
