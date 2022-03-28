class RenameColumnToAnswersAnswererId < ActiveRecord::Migration[6.1]
  def change
    rename_column :answers, :answerer_id, :user_id
    rename_column :answers, :content, :body
  end
end
