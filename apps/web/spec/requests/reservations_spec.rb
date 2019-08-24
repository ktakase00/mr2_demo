require 'rails_helper'

module ReservationsSpecHelper
end

RSpec.describe "Reservations", type: :request do
  include ReservationsSpecHelper

  describe "GET /reservations/new" do
    it "works! (now write some real specs)" do
      get new_reservation_path
      expect(response).to have_http_status(200)
#      puts response.body
    end
  end
end
