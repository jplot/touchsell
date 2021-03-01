class CreateNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.references :record, polymorphic: true, null: false
      t.references :node, foreign_key: true
      t.string :name, null: false
      t.boolean :primary, null: false, default: false

      t.timestamps
    end
  end
end
