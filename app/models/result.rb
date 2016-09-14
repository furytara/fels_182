class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer
  validates :lesson, presence: true
  validates :word, presence: true
  scope :filter_by_word, ->(word_id) do
    where(word_id: word_id) unless word_id.blank?
  end
end
