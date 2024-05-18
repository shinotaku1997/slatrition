class Body < ApplicationRecord
  belongs_to :user
  has_one :goal, dependent: :destroy
  validates :sex, presence: true, numericality: {in: 1..2}
  validates :age, presence: true, numericality: true
  validates :weight, presence: true, numericality: true
  validates :height, presence: true, numericality: true

  enum sex: {male: 1,famale: 2}
end
