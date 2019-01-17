class InstructionsController < ApplicationController

  def show

  end

  def new
    @instruction = Recipe.find(params[:recipe]).instructions.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy
  end

  def recipe_params
      params.fetch(:instruction, {}).permit(:body)
  end
end
