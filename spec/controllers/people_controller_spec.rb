require "rails_helper"
RSpec.describe PeopleController do
  describe "POST #upload_csv" do
    it "redirects to the home page" do
      allow(People).to receive(:upload_csv).with("people.csv")
      post :upload_csv, file: "people.csv"
      expect(response).to redirect_to root_url
    end

    it "adds a flash notice" do
      allow(People).to receive(:upload_csv).with("people.csv")
      post :upload_csv, file: "people.csv"
      expect(flash[:notice]).to eq "People imported successfully."
    end

    it "imports the people file" do
      expect(People).to receive(:upload_csv).with("people.csv")
      post :upload_csv, file: "people.csv"
    end
  end
end