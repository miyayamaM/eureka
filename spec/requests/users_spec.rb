require 'rails_helper'

RSpec.describe "Users", type: :request do

  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:other_user) }

  describe "#Edit" do
    context "logged in" do
      it "is successful with valid information" do
        log_in_as user
        get edit_user_path(user)
  
        patch user_path(user), params: { user: {name: "changed", email: "changed@example.com", password: "newpassword", password_confirmation: "newpassword"} }
        
        user.reload
        expect(user.name).to eq "changed"
        expect(user.email).to eq "changed@example.com"
      end

      it "redirects with friendly forwarding" do
        get edit_user_path(user)
        follow_redirect!
        post login_path, params: {
          session: {
            email: user.email,
            password: user.password
          }
        }

        expect(response).to redirect_to("/users/#{user.id}/edit")
      end
  
      it "doesn't allow for a user to edit other user " do
        log_in_as user
        get edit_user_path(user)
  
        patch user_path(other_user), params: { user: {name: "changed", email: "changed@example.com", password: "newpassword", password_confirmation: "newpassword"} }
        
        other_user.reload
        expect(other_user.name).to_not eq "changed"
        expect(other_user.email).to_not eq "changed@example.com"
        expect(response).to redirect_to(root_url)
      end
    end

    context "not logged in" do
      it "redirects to login path" do
        get edit_user_path(user)
        expect(response).to redirect_to(login_url)

        patch user_path(user), params: { user: {name: "changed", email: "changed@example.com", password: "newpassword", password_confirmation: "newpassword"} }
        expect(response).to redirect_to(login_url)
      end
    end
      
  end

  describe "#Index" do
    context "not logged in" do
      it "redirects to login path" do
        get users_path
        expect(response).to redirect_to(login_url)
      end
    end
  end

  describe "#Destroy" do

    context "logged in" do
      it "deletes himself" do
       log_in_as user

       expect {
         delete user_path(user)
       }.to change(User, :count).by(-1)
      end

      it "doesn't allow to delete other user" do
        log_in_as user

        expect {
          delete user_path(other_user)
        }.to change(User, :count).by(0)
        expect(response).to redirect_to(root_url)
      end
    end

    context "not logged in" do
      it "redirects to login path" do
        get users_path
        expect(response).to redirect_to(login_url)
      end
    end
  end
end