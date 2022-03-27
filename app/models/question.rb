class Question < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  
  has_many :answers

  scope :title_like_search, ->(param) {
    where('title LIKE ?', "%#{params}%").order(created_at: :desc)
  }
end
