require "spec_helper"

describe RecordsController do
  describe "basic routing" do

    it "routes to #index" do
      get("/records").should route_to("records#index")
    end

    it "routes to #show" do
      get("/records/1").should route_to("records#show", :id => "1")
    end
  end
  describe "nested routing" do

    it "routes to #new" do
      get("/emu_people/24/records/new").should route_to(action: "new", controller: "records", :emu_person_id => "24")
    end

    it "routes to #edit" do
      get("/emu_people/24/records/1/edit").should route_to(action: "edit", controller: "records", :emu_person_id => "24", :id => "1")
    end

    it "routes to #create" do
      post("/emu_people/24/records").should route_to(action: "create", controller: "records", :emu_person_id => "24",)
    end

    it "routes to #update" do
      put("/records/1").should route_to("records#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/emu_people/24/records/1").should route_to(action: "destroy", controller: "records", :emu_person_id => "24", :id => "1")
    end

  end
end
