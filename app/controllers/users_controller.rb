class UsersController < ApplicationController
 	before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
 	before_action :correct_user, only: [:edit, :update]
 	before_action :admin_user, only: [:destroy]
 	before_action :signed_up_user, only: [:new, :create]

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			redirect_to @user, flash: { success: "Welcome to the Sample App!" }
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update_attributes user_params
			sign_in @user
			redirect_to @user, flash: { success: "Profile updated" }
		else
			render 'edit'
		end
	end

	def index
		@users = User.paginate page: params[:page]
	end

	def destroy
		to_delete = User.find(params[:id])
		if to_delete != current_user
			to_delete.destroy
			redirect_to users_url, flash: { success: "User deleted" }
		else
			redirect_to users_url, flash: { error: "You cannot delete yourself" }
		end
	end

	private 

	def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def signed_up_user
    	if signed_in?
    		redirect_to root_url, notice: "You already are a registered user"
    	end
    end

    def correct_user
    	@user = User.find(params[:id])
    	redirect_to root_url unless current_user?(@user)    	
    end

    def admin_user
    	redirect_to root_url unless current_user.admin?
    end
end
