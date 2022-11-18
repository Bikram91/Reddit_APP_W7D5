class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_session_url
    end
  end

  def new
    render :new
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
