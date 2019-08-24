require 'rails_helper'

module UsersRequestSpecHelper
end

RSpec.describe "Users", type: :request do
  include UsersRequestSpecHelper

  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end
end
