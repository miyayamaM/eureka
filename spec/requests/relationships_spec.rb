# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }

  describe '#Create' do
    context 'not logged in' do
      it 'redirects to login_path' do
        expect do
          post relationships_path
        end.to change(Relationship, :count).by(0)

        expect(response).to redirect_to login_url
      end
    end
  end

  describe '#Destroy' do
    context 'not logged in' do
      it 'redirects to login_path' do
        relationship = Relationship.create(follower_id: user.id, followed_id: other_user.id)
        expect do
          delete relationship_path(relationship)
        end.to change(Relationship, :count).by(0)

        expect(response).to redirect_to login_url
      end
    end
  end
end
