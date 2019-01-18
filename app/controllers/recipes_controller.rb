class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :delete_picture]
  before_action :logged_in?, only: [:new, :edit, :create, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all.order(:updated_at).reverse
    filtered = filter_recipes_by_tag(params[:filtertag].to_s, @recipes)
    @tags = []
    @recipes.each do |r|
      unless r.tags.nil?
        r.tags.each do |t|
          unless @tags.include? t
            @tags << t
          end
        end
      end
    end
    @tags.sort!
    if !filtered.empty?
      @recipes = filtered unless filtered.empty?
      @recipes.reverse!
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @user = User.find(@recipe.user_id)
    @instructions = @recipe.instructions
  end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.new

  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = current_user.recipes.new(recipe_params)
    @recipe.tags = params.fetch(:recipe, {}).permit(:tags)["tags"].to_s.split(";")

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to new_recipe_instruction_path(recipe_id: @recipe.id), notice: 'Recipe was successfully created.' }
        # format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      @recipe.tags = params.fetch(:recipe, {}).permit(:tags)["tags"].to_s.split(";")
      if @recipe.update(recipe_params)
        format.html { redirect_to new_recipe_instruction_path(recipe_id: @recipe.id), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_picture
    @recipe.picture.purge_later
    redirect_to edit_recipe_path(@recipe), notice: "Picture deleted"
  end

  private

  def filter_recipes_by_tag(filtertag, recipes)
    filtered = []
    recipes.each do |r|
      unless r.tags.nil?
        if r.tags.include? filtertag
          filtered << r
        end
      end
    end
    filtered
  end

  def filter_tags(tagsString)
    # so we expect tagsString to be something like:
    # breakfast;lunch;wow;big gains;
    tagsString.split(";")

  end
  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recipe_params
    params.fetch(:recipe, {}).permit(:title, :ingredients, :instructions, :picture)
  end

end
