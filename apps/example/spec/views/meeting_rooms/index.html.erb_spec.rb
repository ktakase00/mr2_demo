require 'rails_helper'

RSpec.describe "meeting_rooms/index", type: :view do
  before(:each) do
    assign(:meeting_rooms, [
      MeetingRoom.create!(
        :meeting_room_nm => "MyText",
        :memo_content => "MyText"
      ),
      MeetingRoom.create!(
        :meeting_room_nm => "MyText",
        :memo_content => "MyText"
      )
    ])
  end

  it "renders a list of meeting_rooms" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
