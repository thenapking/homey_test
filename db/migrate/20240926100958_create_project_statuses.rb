class CreateProjectStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :project_statuses do |t|
      t.integer :status, null: false, default: 0
      t.references :user, null: false, foreign_key: true, index: true
      t.references :project, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
