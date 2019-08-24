class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations, { id: :bigserial } do |t|
      t.text :title, null: false, default: ''
      t.column :user_id, :bigint, null: false, default: 0
      t.column :meeting_room_id, :bigint, null: false, default: 0
      t.column :start_at, :timestamptz, null: false
      t.column :end_at, :timestamptz, null: false
      t.text :memo_content, null: false, default: ''

      t.column :created_at, :timestamptz, null: false
      t.column :updated_at, :timestamptz, null: false
    end
  end
end
