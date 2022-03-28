class RenameColumnToQuestionsContent < ActiveRecord::Migration[6.1]
  def change
    rename_column :questions, :content, :body
  end
end
