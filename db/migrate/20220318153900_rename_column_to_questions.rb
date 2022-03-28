class RenameColumnToQuestions < ActiveRecord::Migration[6.1]
  def change
    rename_column :questions, :is_solved, :solved
  end
end
