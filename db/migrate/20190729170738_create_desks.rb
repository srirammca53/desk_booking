class CreateDesks < ActiveRecord::Migration
  def change
    create_table :desks do |t|
      t.string :user_name
      t.string :desk
      t.date :from_date
      t.date :to_date
      t.boolean :status
      t.string :email

      t.timestamps null: false
    end
  end
end
