class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results
  has_many :lessons, through: :results
  validates :content, presence: true, length: {maximum: 50}
  validate :checked_answer, on: [:create, :update]
  before_save :update_updated_at_field
  accepts_nested_attributes_for :answers, allow_destroy: true
  scope :by_category, ->(category_id) do
    condition = category_id.blank? ? nil : "category_id = #{category_id}"
    where(condition).order updated_at: :desc
  end

  def invalid_to_delete?
    self.lessons.any?
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

  def update_updated_at_field
    self.updated_at = Time.zone.now
  end
end

