class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :done
      t.belongs_to :lists
      t.timestamps null: false
    end
  end
end
