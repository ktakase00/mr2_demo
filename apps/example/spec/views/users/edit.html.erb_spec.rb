require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :mail => "MyText",
      :user_nm => "MyText"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "textarea[name=?]", "user[mail]"

      assert_select "textarea[name=?]", "user[user_nm]"
    end
  end
end
