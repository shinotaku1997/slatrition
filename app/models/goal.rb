class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :body
  validates :goal_weight, presence: true, numericality: true
  validates :volume_of_activity, presence: true, numericality: {in: 0..4}
  enum volume_of_activity: {low: 0, light: 1, middle: 2, high: 3, very_high: 4}
end
