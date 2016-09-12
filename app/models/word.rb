class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results
  has_many :lessons, through: :results
  validates :content, presence: true, length: {maximum: 50}
  validate :checked_answer, on: :create
  accepts_nested_attributes_for :answers, allow_destroy: true
  scope :by_category, ->(category_id) do
    where(category_id: category_id) unless category_id.blank?
  end

  def correct_answer
    answer = self.answers.detect {|answer| answer.is_true?}
    answer.content
  end

  private
  def checked_answer
    has_answer = self.answers.detect {|answer| answer.is_true?}
    errors[:base] << I18n.t("model.word.select-an-answer") if has_answer.nil?
  end
end

