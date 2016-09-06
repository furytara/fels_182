class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results
  has_many :words, through: :results
end
