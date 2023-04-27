class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :recipe, class_name: 'Recipe'
end
