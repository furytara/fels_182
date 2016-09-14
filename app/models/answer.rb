class Answer < ActiveRecord::Base
  belongs_to :word
  has_many :results
  validates :content, presence: true, length: {maximum: 50}
  scope :find_correct_answer, -> do
    find_by(is_true: true)
  end
end
