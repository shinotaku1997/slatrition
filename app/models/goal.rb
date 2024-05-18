class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :body
  validates :target_weight, presence: true
  validates :volume_of_activity, presence: true, numericality: {in: 0..4}
  enum volume_of_activity: {low: 0, light: 1, middle: 2, hight: 3, very_hight: 4}
end
