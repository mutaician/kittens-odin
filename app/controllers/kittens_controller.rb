class KittensController < ApplicationController

  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:notice] = "Kitten was successfully created"
      redirect_to kittens_path
    else
      flash[:alert] = "There was an error creating the kitten, please try again."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update(kitten_params)
      flash[:notice] = "Kitten was successfully updated"
      redirect_to @kitten
    else
      flash[:alert] = "There was an error updating the kitten, please try again."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    if @kitten.destroy
      flash[:notice] = "Kitten was successfully deleted"
    else
      flash[:alert] = "There was an error deleting the kitten, please try again."
    end
    redirect_to kittens_path
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
