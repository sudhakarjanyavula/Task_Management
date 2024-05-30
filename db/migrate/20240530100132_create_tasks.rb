class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.references :user, foreign_key: true
      t.string :status, default: 'Backlog'
      t.timestamps
    end
  end
end
