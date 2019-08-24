require 'rails_helper'

RSpec.describe "reservations/new", type: :view do
  before(:each) do
    assign(:reservation, Reservation.new(
      :title => "MyText",
      :user_id => "",
      :meeting_room_id => "",
      :start_at => "",
      :end_at => "",
      :memo_content => "MyText"
    ))
  end

  it "renders new reservation form" do
    render

    assert_select "form[action=?][method=?]", reservations_path, "post" do

      assert_select "textarea[name=?]", "reservation[title]"

      assert_select "input[name=?]", "reservation[user_id]"

      assert_select "input[name=?]", "reservation[meeting_room_id]"

      assert_select "input[name=?]", "reservation[start_at]"

      assert_select "input[name=?]", "reservation[end_at]"

      assert_select "textarea[name=?]", "reservation[memo_content]"
    end
  end
end
