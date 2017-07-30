class ChefsController < ApplicationController
  
  before_action :set_chef, only: [:show, :edit, :update] 
  
  def new
   @chef = Chef.new; 
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save 
       flash[:success] = "Welcome #{@chef.chefname.capitalize} to MyRecipes App!"
       redirect_to chef_path(@chef)     
    else
      render "new"
    end
  end
  
  def show 
    
  end
  
  def edit
    
  end
  
  def update
    if @chef.update(chef_params)
      flash[:success] = "Profile was updated successfully!"
      redirect_to @chef
    else
      render "edit"
    end
  end
  
  private
  def set_chef
    @chef = Chef.find(params[:id]) 
  end  
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end
end