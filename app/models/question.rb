class Question < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :is_solved, presence: true

  belongs_to :user
  has_many :answers
end
