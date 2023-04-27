class RecipeFood < ApplicationRecord
  has_many :recipe_foods, class_name: 'RecipeFood'
  belongs_to :food
end
