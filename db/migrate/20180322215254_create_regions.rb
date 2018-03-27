class CreateRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :regions do |t|
      t.string :name
      t.references :country, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
