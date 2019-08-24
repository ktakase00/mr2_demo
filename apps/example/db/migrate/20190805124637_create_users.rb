class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, { id: :bigserial } do |t|
      t.text :user_cd, null: false, default: ''
      t.text :user_nm, null: false, default: ''

      t.column :created_at, :timestamptz, null: false
      t.column :updated_at, :timestamptz, null: false
    end

    add_index :users, :user_cd, unique: true
  end
end
