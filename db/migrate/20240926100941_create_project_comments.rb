class CreateProjectComments < ActiveRecord::Migration[7.0]
  def change
    create_table :project_comments do |t|
      t.text :comment
      t.references :user, null: false, foreign_key: true, index: true
      t.references :project, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
