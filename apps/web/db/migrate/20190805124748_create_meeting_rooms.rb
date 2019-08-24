class CreateMeetingRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :meeting_rooms, { id: :bigserial } do |t|
      t.text :meeting_room_nm, null: false, default: ''
      t.text :memo_content, null: false, default: ''

      t.column :created_at, :timestamptz, null: false
      t.column :updated_at, :timestamptz, null: false
    end
  end
end
