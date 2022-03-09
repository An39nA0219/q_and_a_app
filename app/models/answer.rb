class Answer < ApplicationRecord
  validates :content, presence: true
  
  belongs_to :question, dependent: :destroy
  belongs_to :answerer, class_name: 'User', foreign_key: :answerer_id
end
