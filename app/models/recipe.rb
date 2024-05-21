class Recipe < ApplicationRecord
    validates :individual_id, presence: true
end
