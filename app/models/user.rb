class User < ApplicationRecord
  has_secure_password
  before_save { email.downcase! }
  before_create :default_image
  before_destroy :prevent_to_destroy_admin_user
  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_one_attached :image

  scope :all_others, ->(user_id) { where.not(id: user_id) }

  scope :all_other_users_with_questioner, ->(user_id, question) { where.not(id: user_id).joins(:answers).where(answers: { question_id: question.id }) }
  
  scope :all_other_users_with_questioner, ->(user_id, question) { 
    where.not(id: user_id).joins(:answers).where(answers: { question_id: question.id }) 
  }

  def default_image
    if !self.image.attached?
      self.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_user.png')), filename: 'default_user.png', content_type: 'image/png')
    end
  end

  def prevent_to_destroy_admin_user
    throw(:abort) if self.admin
  end
end
