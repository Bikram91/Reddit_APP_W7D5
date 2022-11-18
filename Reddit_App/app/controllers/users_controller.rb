class UsersController < ApplicationController
    before_action :require_logged_in, only:[:show, :index]
    before_action :grab_user, only:[:show, :edit, :update]
    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end

    end

    def new
        @user = User.new
        render :new
    end

    def show

    end

    def edit

    end

    def update
        if @user.update(user_params)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :edit
        end
    end

    def index
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end

    def grab_user
        @user = User.find_by(id: params[:id])

    end
end
