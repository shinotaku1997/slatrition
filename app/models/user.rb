class User < ApplicationRecord
  has_one :goal, dependent: :destroy
  has_one :body, dependent: :destroy
  authenticates_with_sorcery!
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarks_recipes, through: :bookmarks, source: :recipe
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  
  def own?(object)
    id == object.user_id
  end

  def bookmark(recipe)
    bookmarks_recipes << recipe
  end

  def unbookmark(recipe)
    bookmarks_recipes.delete(recipe)
  end

  def bookmarks?(recipe)
    bookmarks_recipes.include?(recipe)
  end
end
