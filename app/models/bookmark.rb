# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user_id, presence: true, uniqueness: { scope: :article_id }
  validates :article_id, presence: true
end
