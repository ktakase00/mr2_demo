require "rails_helper"

RSpec.describe MeetingRoomsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/meeting_rooms").to route_to("meeting_rooms#index")
    end

    it "routes to #new" do
      expect(:get => "/meeting_rooms/new").to route_to("meeting_rooms#new")
    end

    it "routes to #show" do
      expect(:get => "/meeting_rooms/1").to route_to("meeting_rooms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/meeting_rooms/1/edit").to route_to("meeting_rooms#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/meeting_rooms").to route_to("meeting_rooms#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/meeting_rooms/1").to route_to("meeting_rooms#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/meeting_rooms/1").to route_to("meeting_rooms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/meeting_rooms/1").to route_to("meeting_rooms#destroy", :id => "1")
    end
  end
end
