class InstructionsController < ApplicationController

  def show

  end

  def new
    @recipe = Recipe.find(params[:recipe])
    @instruction = @recipe.instructions.new
    @addedInstructions = @recipe.instructions
  end

  def create
    @recipe = Recipe.find(params[:recipe])
    @instruction = @recipe.instructions.new(instruction_params)

    respond_to do |format|
      if @instruction.save
        format.html { redirect_to new_instruction_path(recipe: @recipe.id), notice: 'instruction was successfully created.' }
        # format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update

  end

  def destroy
  end

  def instruction_params
      params.fetch(:instruction, {}).permit(:body, :recipe)
  end
end
