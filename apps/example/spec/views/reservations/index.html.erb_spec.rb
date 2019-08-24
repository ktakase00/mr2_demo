require 'rails_helper'

RSpec.describe "reservations/index", type: :view do
  before(:each) do
    assign(:reservations, [
      Reservation.create!(
        :title => "MyText",
        :user_id => "",
        :meeting_room_id => "",
        :start_at => "",
        :end_at => "",
        :memo_content => "MyText"
      ),
      Reservation.create!(
        :title => "MyText",
        :user_id => "",
        :meeting_room_id => "",
        :start_at => "",
        :end_at => "",
        :memo_content => "MyText"
      )
    ])
  end

  it "renders a list of reservations" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
