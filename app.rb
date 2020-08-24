require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  # '<h1>Hello <em>world</em>!</h1>'
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  @all_recipes = cookbook.all
  erb :index
end

get '/about' do
  erb :about
end

get '/team/:username' do
  # binding.pry
  puts params[:username]
  "The username is #{params[:username]}"
end

get '/new' do
  erb :new
end


post '/recipes' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  recipe = Recipe.new(
    params[:name],
    params[:description],
    params[:time],
    params[:done],
    params[:difficulty]
    )
  cookbook.add_recipe(recipe)
  redirect to '/'
end
