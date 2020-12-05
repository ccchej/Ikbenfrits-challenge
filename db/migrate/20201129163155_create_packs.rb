class CreatePacks < ActiveRecord::Migration[6.0]
  def change
    create_table :packs do |t|
      t.string :code
      t.integer :pastry_id
      t.integer :qty
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
