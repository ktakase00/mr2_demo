require 'rails_helper'

RSpec.describe "meeting_rooms/show", type: :view do
  before(:each) do
    @meeting_room = assign(:meeting_room, MeetingRoom.create!(
      :meeting_room_nm => "MyText",
      :memo_content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
