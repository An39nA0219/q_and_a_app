class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :content
      t.boolean :is_solved, default: false

      t.timestamps
    end
  end
end
