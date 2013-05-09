require "spec_helper"

describe CareersController do
  describe "routing" do

    it "routes to #index" do
      get("/careers").should route_to("careers#index")
    end

    it "routes to #new" do
      get("/careers/new").should route_to("careers#new")
    end

    it "routes to #show" do
      get("/careers/1").should route_to("careers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/careers/1/edit").should route_to("careers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/careers").should route_to("careers#create")
    end

    it "routes to #update" do
      put("/careers/1").should route_to("careers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/careers/1").should route_to("careers#destroy", :id => "1")
    end

  end
end
