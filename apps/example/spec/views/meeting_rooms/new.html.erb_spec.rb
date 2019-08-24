require 'rails_helper'

RSpec.describe "meeting_rooms/new", type: :view do
  before(:each) do
    assign(:meeting_room, MeetingRoom.new(
      :meeting_room_nm => "MyText",
      :memo_content => "MyText"
    ))
  end

  it "renders new meeting_room form" do
    render

    assert_select "form[action=?][method=?]", meeting_rooms_path, "post" do

      assert_select "textarea[name=?]", "meeting_room[meeting_room_nm]"

      assert_select "textarea[name=?]", "meeting_room[memo_content]"
    end
  end
end
