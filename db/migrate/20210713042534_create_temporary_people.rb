class CreateTemporaryPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :temporary_people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.text :validation_errors
      t.boolean :processed, default: false

      t.timestamps
    end
  end
end
