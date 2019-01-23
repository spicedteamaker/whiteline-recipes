class InstructionsController < ApplicationController
  before_action :set_instruction, only: [:show, :edit, :update, :destroy, :delete_picture]
  before_action :set_recipe, only: [:new, :edit, :update, :create, :destroy, :delete_picture]
  before_action :logged_in?, only: [:new, :create, :edit, :update, :destroy, :delete_picture]
  def show

  end

  def new
    @addedInstructions = @recipe.instructions.all
    @instruction = @recipe.instructions.new
  end

  def create
    @instruction = @recipe.instructions.new(instruction_params)

    respond_to do |format|
      if @instruction.save
        format.html { redirect_to new_recipe_instruction_path(recipe_id: @recipe.id), notice: 'instruction was successfully created.' }
        # format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @instruction.update(instruction_params)
        format.html { redirect_to new_recipe_instruction_path(recipe_id: @recipe.id), notice: 'instruction was successfully updated.' }
        # format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @instruction.destroy
    respond_to do |format|
      format.html { redirect_to new_recipe_instruction_path(recipe_id: @recipe.id), notice: 'instruction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_picture
    @instruction.picture.purge_later
    redirect_to edit_recipe_instruction_path(@recipe, @instruction), notice: "Picture deleted"
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_instruction
    @instruction = Instruction.find(params[:id])
  end

  def instruction_params
      params.fetch(:instruction, {}).permit(:body, :picture)
  end
end
