require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  let(:user) { FactoryBot.create(:user) }

  describe "Login" do

    it "is successful with valid information" do
      get login_path
      post login_path, params: { session: {email: "#{user.email}", password: "#{user.password}" } }
      
      expect(is_logged_in?).to be_truthy
    end
  end

  describe "Logout" do

    it "is successful with one request" do
      get login_path
      post login_path, params: { session: {email: "#{user.email}", password: "#{user.password}" } }

      delete logout_path
      expect(is_logged_in?).to be_falsey
    end

    it "redirects to login page with duplicated requests" do
      get login_path
      post login_path, params: { session: {email: "#{user.email}", password: "#{user.password}" } }

      delete logout_path
      expect(is_logged_in?).to be_falsey

      delete logout_path

      expect(response).to redirect_to(root_path)
    end
  end
end