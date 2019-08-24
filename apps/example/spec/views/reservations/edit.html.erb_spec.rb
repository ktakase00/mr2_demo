require 'rails_helper'

RSpec.describe "reservations/edit", type: :view do
  before(:each) do
    @reservation = assign(:reservation, Reservation.create!(
      :title => "MyText",
      :user_id => "",
      :meeting_room_id => "",
      :start_at => "",
      :end_at => "",
      :memo_content => "MyText"
    ))
  end

  it "renders the edit reservation form" do
    render

    assert_select "form[action=?][method=?]", reservation_path(@reservation), "post" do

      assert_select "textarea[name=?]", "reservation[title]"

      assert_select "input[name=?]", "reservation[user_id]"

      assert_select "input[name=?]", "reservation[meeting_room_id]"

      assert_select "input[name=?]", "reservation[start_at]"

      assert_select "input[name=?]", "reservation[end_at]"

      assert_select "textarea[name=?]", "reservation[memo_content]"
    end
  end
end
