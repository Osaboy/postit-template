class CategoriesController < ApplicationController

####################### DISPLAYING EXISTING CATEGORIES #######################

def show
  @category = Category.find(params[:id])
end

####################### CREATE A NEW CATEGORY #######################
def new
  @category = Category.new
end

def create
  #binding.pry

  @category = Category.new(category_params)
  if @category.save
    flash[:notice] = "Your category has been created"
    redirect_to root_path
  else
    render :new
  end
end

####################### PRIVATE CATERGORIES CONTROLLER METHODS #######################

private

  def category_params
    params.require(:category).permit(:name)
  end

end