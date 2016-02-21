class Bookmark < ActiveRecord::Base

  belongs_to :bookmarkable, polymorphic: true
  belongs_to :user

  validates :user, :bookmarkable, presence: true
end
