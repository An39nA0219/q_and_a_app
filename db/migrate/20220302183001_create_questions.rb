class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.boolean :is_solved

      t.timestamps
    end
  end
end
