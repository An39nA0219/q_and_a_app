class User < ApplicationRecord
  has_secure_password
  before_save { self.email.downcase! }
  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true

  has_many :questions, dependent: :destroy
  has_many :answers, foreign_key: :answerer_id
end
