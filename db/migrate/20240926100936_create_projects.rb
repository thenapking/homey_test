class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :status, null: false, default: 0
      t.references :user, null: false, foreign_key: true, index: true
      
      t.timestamps
    end
  end
end
