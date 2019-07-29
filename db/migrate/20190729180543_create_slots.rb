class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.string :name
      t.boolean :status

      t.timestamps null: false
    end
  end
end
