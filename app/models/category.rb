class Category < ActiveRecord::Base
  has_many :words
  has_many :lessons
  scope :update_desc, -> {order(updated_at: :desc)}
  scope :alphabet, -> {order(:name)}
  validates :name, presence: true, length: {maximum: 140}

  def valid_to_delete?
    self.words.any?
  end

  class << self
    def search search
      where("name LIKE ?", "%#{search}%").update_desc
    end
  end
end
