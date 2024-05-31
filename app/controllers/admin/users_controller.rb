class Admin::UsersController < Admin::AdminController

    def index
        @users = User.all
    end

    def destroy
     @user = User.find(params[:id])
     if @user.admin
        redirect_to admin_users_path , notice: 'User is admin, cannot deleted.'
     else
        @user.destroy
        redirect_to admin_users_path , notice: 'User was successfully destroyed.'
     end 
    end

end
  