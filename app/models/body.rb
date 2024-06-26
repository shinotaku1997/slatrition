class Body < ApplicationRecord
  belongs_to :user
  has_one :goal, dependent: :destroy
  validates :sex, presence: true, numericality: {in: 0..2}
  validates :age, presence: true, numericality: true
  validates :weight, presence: true, numericality: true
  validates :height, presence: true, numericality: true
  accepts_nested_attributes_for :goal

  enum sex: { male: 0, female: 1 }
end
