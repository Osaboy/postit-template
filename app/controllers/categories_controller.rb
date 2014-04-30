class CategoriesController < ApplicationController

 # 2. redirect based on some condition
before_action :require_user, except: [:show]

####################### DISPLAYING EXISTING CATEGORIES #######################

def show
  @category = Category.find_by(slug: params[:id])
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