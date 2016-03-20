class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :firstname
      t.string :lastname

      t.timestamps null: false
    end
  end
end
