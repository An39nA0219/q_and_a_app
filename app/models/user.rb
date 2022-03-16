class User < ApplicationRecord
  has_secure_password
  before_save { email.downcase! }
  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true

  has_many :questions
  has_many :answers, foreign_key: :answerer_id
  has_one_attached :image

  scope :all_others, ->(user_id) { where.not(id: user_id) }

  scope :all_other_answerers_with_questioner, ->(user_id, question) {
    answerer_ids = question.answers.map{ |a| a.answerer.id }
    questioner_id = question.user.id
    target_ids = answerer_ids << questioner_id
    where(id: target_ids).all_others(user_id)
  }
end
