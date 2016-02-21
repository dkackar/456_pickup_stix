class Artist < ActiveRecord::Base
   has_many :songs
   has_many :bookmarks, -> { order('created_at ASC') }, as: :bookmarkable, dependent:   :destroy

   validates :name, presence: true 

end
