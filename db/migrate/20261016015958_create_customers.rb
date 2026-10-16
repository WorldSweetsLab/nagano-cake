class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :phone_number, null: false
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.boolean :is_active, default: true, null: false
      t.timestamps
    end
    add_index :customers, :email_address, unique: true
  end
end
