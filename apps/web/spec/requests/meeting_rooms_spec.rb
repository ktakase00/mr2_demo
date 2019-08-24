require 'rails_helper'

RSpec.describe "MeetingRooms", type: :request do
  let (:login_user) { create(:user) }

  before (:each) do
    post sessions_path, params: { session_form: { user_cd: login_user.user_cd } }, headers: headers
  end

  describe "GET /meeting_rooms" do
    it "works! (now write some real specs)" do
      get meeting_rooms_path
      expect(response).to have_http_status(200)
    end
  end
end
