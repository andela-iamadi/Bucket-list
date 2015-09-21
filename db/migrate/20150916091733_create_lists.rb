class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.boolean :done
      t.belongs_to :items
      t.timestamps null: false
    end
  end
end
