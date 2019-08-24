class CreateReservationUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_users, { id: :bigserial } do |t|
      t.column :reservation_id, :bigint, null: false, default: 0
      t.column :user_id, :bigint, null: false, default: 0
      t.column :attendance_flag, :boolean, null: false, default: false

      t.column :created_at, :timestamptz, null: false
      t.column :updated_at, :timestamptz, null: false
    end
  end
end
