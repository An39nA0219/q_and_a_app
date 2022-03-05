class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :answerer, class_name: 'User', foreign_key: :answerer_id
end
