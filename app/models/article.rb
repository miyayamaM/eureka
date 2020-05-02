class Article < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :title, presence: true,  length: { maximum: 100 }
  validates :content, presence: true

  mount_uploader :thumbnail, ThumbnailUploader

  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
end
