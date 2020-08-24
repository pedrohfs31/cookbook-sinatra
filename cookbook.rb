require 'csv'

class Cookbook
  attr_accessor :recipes

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    recipe_index = recipe_index.to_i - 1
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def update(recipe_index)
    recipe_index = recipe_index.to_i - 1
    @recipes[recipe_index].done = "true"
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |row|
      @recipes.each do |recipe|
        row << [
          recipe.name,
          recipe.description,
          recipe.prep_time,
          recipe.done,
          recipe.difficulty
        ]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end
end
