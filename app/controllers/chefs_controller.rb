class ChefsController < ApplicationController
  
  before_action :set_chef, only: [:show, :edit, :update, :destroy] 
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]  
  
  def destroy
    if !@chef.admin?
      @chef.delete
      flash[:success] = "Chef and all affiliated recipes have been deleted"   
      redirect_to chefs_path
    end 
  end
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end
  
  def new
   @chef = Chef.new; 
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save 
       session[:chef_id] = @chef.id
       cookies.signed[:chef_id] = @chef.id       
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
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 2)
  end  
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end
  
  def require_same_user
    if (current_chef != @chef && !current_chef.admin?)
      flash[:danger] = "You can only edit your own profile"
      redirect_to chefs_path
    end
  end
  
  def require_admin
    if (logged_in? && !current_chef.admin?)
      flash[:danger] = "Only admin can delete a profile"
      redirect_to chefs_path
    end    
  end
end