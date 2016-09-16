class Lesson < ActiveRecord::Base
  after_create :create_word_for_specify_lesson
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  validates :user, presence: true
  validates :category, presence: true
  accepts_nested_attributes_for :results

  private
  def create_word_for_specify_lesson
    @words = Word.unlearned.randomize Settings.word_per_page
    @words.each do |word|
      self.results.build word_id: word.id
    end
  end
end
