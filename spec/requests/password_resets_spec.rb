require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  
  let(:user) { FactoryBot.create(:user) }
  let(:unactivated_user) { FactoryBot.create(:unactivated_user) }

  describe "sending email" do

    before do
      ActionMailer::Base.deliveries.clear
    end

    context "fill in valid email" do
      it "sends an email to valid email address" do
        get new_password_reset_path
        expect(response).to have_http_status "200"
  
        post password_resets_path, params: { password_reset: { email: "#{user.email}" } }
  
        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(flash.empty?).to be_falsey
        expect(response).to redirect_to(root_url)
      end
    end

    context "fill in invalid email" do
      it "renders email submit form " do
        get new_password_reset_path
        expect(response).to have_http_status "200"
  
        post password_resets_path, params: { password_reset: { email: "" } }
  
        expect(ActionMailer::Base.deliveries.size).to eq 0
        expect(flash.empty?).to be_falsey
        expect(response).to render_template('password_resets/new')
      end
    end
  end

  describe "access to embeded link" do

    before do
      user.create_reset_digest
    end

    context "valid token and valid email" do
      it "returns success" do
        get edit_password_reset_path(user.reset_token, email: user.email)

        expect(response).to have_http_status "200"
      end
    end

    context "invalid token and valid email" do
      it "redirects root" do
        user.create_reset_digest
        get edit_password_reset_path('wrong_token', email: user.email)

        expect(response).to redirect_to(root_url)
      end
    end

    context "valid token and invalid email" do
      it "redirects root" do
        user.create_reset_digest
        get edit_password_reset_path(user.reset_token, email: "")

        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "update password" do

    before do
      user.create_reset_digest
      get edit_password_reset_path(user.reset_token, email: user.email)
    end

    context "valid password" do
      it "saves new password" do
        patch password_reset_path(user.reset_token), params: { email: user.email,
                                                              user: {password: "changed",
                                                                password_confirmation: "changed" } }

        expect(user.reload.authenticate("changed")).to be_truthy
        expect(response).to redirect_to(login_url)
      end

    end

    context "wrong password" do
      it "doesn't change password" do
        patch password_reset_path(user.reset_token), params: { email: user.email,
                                                              user: {password: "",
                                                                password_confirmation: "" } }

        expect(user.reload.authenticate("")).to be_falsey
        expect(user.reload.authenticate("password")).to be_truthy
        expect(response).to render_template("edit")
      end
    end
  end
end
