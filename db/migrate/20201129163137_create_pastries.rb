class CreatePastries < ActiveRecord::Migration[6.0]
  def change
    create_table :pastries do |t|
      t.string :name
      t.timestamps
    end
  end
end
