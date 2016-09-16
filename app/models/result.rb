class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer
  validates :lesson, presence: true
  validates :word, presence: true
  scope :count_correct_answer, -> do
    joins(:answer).where(answers: {is_true: true}).count
  end
end
