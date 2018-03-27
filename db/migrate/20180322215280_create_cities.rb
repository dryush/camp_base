class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.references :region, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
