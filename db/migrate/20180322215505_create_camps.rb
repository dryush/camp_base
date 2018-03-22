class CreateCamps < ActiveRecord::Migration[5.1]
  def change
    create_table :camps do |t|
      t.string :name
      t.string :description
      t.references :city, foreign_key: true

      #t.timestamps
    end
  end
end
