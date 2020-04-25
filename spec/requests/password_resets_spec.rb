require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do

  describe "success" do

    let(:user) { FactoryBot.create(:user) }
    let(:unactivated_user) { FactoryBot.create(:unactivated_user) }

    before do
      ActionMailer::Base.deliveries.clear
    end

    context "valid email" do

      it "sends an email to valid email address" do
        get new_password_reset_path
        expect(response).to have_http_status "200"

        post password_resets_path, params: { password_reset: { email: "#{user.email}" } }

        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(flash.empty?).to be_falsey
        expect(response).to redirect_to(root_url)
      end
    end

    context "valid password" do

      it "returns success with valid token" do
       
      end

      it "accepts new valid password" do
       
      end
    end
  end

  context "fail" do
    it "returns error to invalid email address" do
      
    end

    it "returns error to invalid password" do
     
    end
  end
end
