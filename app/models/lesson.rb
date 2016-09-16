class Lesson < ActiveRecord::Base
  after_create :create_word_for_specify_lesson, :create_lesson_activity
  after_update :update_lesson_activity
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  validates :user, presence: true
  validates :category, presence: true
  accepts_nested_attributes_for :results

  private
  def create_word_for_specify_lesson
    @words = Word.unlearned.randomize Settings.word_per_lesson
    @words.each do |word|
      self.results.build word_id: word.id
    end
  end

  def update_lesson_activity
    Activity.create user_id: user_id, target_id: id,
      action_type: :update_lesson
  end

  def create_lesson_activity
    Activity.create user_id: user_id, target_id: id,
      action_type: :create_lesson
  end
end
