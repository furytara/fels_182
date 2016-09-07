class Category < ActiveRecord::Base
  has_many :words
  has_many :lessons
  scope :update_desc, -> {order(updated_at: :desc)}
  validates :name, presence: true, length: {maximum: 140}

  def valid_to_delete?
    self.words.count > 0
  end
end
