# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }

  it 'is valid' do
    comment = FactoryBot.build(:comment)

    expect(comment).to be_valid
  end

  it 'is invalid without user' do
    comment = FactoryBot.build(:comment, user_id: nil)

    expect(comment).to_not be_valid
  end

  it 'is invalid without article' do
    comment = FactoryBot.build(:comment, article_id: nil)

    expect(comment).to_not be_valid
  end

  it 'is valid with 10000 characters content' do
    comment = FactoryBot.build(:comment, content: ('a' * 10000).to_s)

    expect(comment).to be_valid
  end

  it 'is invalid with 10001 characters content' do
    comment = FactoryBot.build(:comment, content: ('a' * 10001).to_s)

    expect(comment).to_not be_valid
  end
end
