class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :content, presence: true, length: { maximum: 10000 }

  default_scope -> { order(created_at: :desc) }
end
