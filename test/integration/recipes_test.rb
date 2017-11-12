require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
   @chef = Chef.create!(chefname: "jason", email: "jsolorio@gmail.com" ) #create! (bang) is to hit the DB
   @recipe = Recipe.create(name: "Ranch Omelettes", description: "delicious spicy eggs ala brava", chef: @chef)
   @recipe2 = @chef.recipes.build(name: "chicken saute", description: "great chicken dish")
   @recipe2.save
  end

  test 'should get recipes index' do
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body  #@recipe.name making reference to ^ and response.body meaning I wanna see the name in the layout's body
    assert_match @recipe2.name, response.body
  end

end
