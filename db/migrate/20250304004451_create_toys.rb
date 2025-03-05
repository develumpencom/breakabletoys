class CreateToys < ActiveRecord::Migration[8.0]
  def change
    create_table :toys do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :url
      t.string :short_description, null: false
      t.integer :status

      t.timestamps
    end
  end
end
