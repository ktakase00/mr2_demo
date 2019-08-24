require 'rails_helper'

RSpec.describe "meeting_rooms/edit", type: :view do
  before(:each) do
    @meeting_room = assign(:meeting_room, MeetingRoom.create!(
      :meeting_room_nm => "MyText",
      :memo_content => "MyText"
    ))
  end

  it "renders the edit meeting_room form" do
    render

    assert_select "form[action=?][method=?]", meeting_room_path(@meeting_room), "post" do

      assert_select "textarea[name=?]", "meeting_room[meeting_room_nm]"

      assert_select "textarea[name=?]", "meeting_room[memo_content]"
    end
  end
end
