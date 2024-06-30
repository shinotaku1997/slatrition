class Recipe < ApplicationRecord
    validates :individual_id, presence: true, uniqueness: true
    validates :calories, numericality: {only_integer: true, greater_than: 0}
    validates :proteins, numericality: {only_integer: true, greater_than: 0}
    validates :carbhydarates, numericality: {only_integer: true, greater_than: 0}
    validates :fats, numericality: {only_integer: true, greater_than: 0}
    validates :salts, numericality: {only_integer: true, greater_than: 0}
    validates :fibers, numericality: {only_integer: true, greater_than: 0}

    has_many :bookmarks, dependent: :destroy
    has_many :users, through: :bookmarks,source: :recipe

    def bookmarked_by?(user)
        bookmarks.where(user_id: user).exists?
      end
    
end
