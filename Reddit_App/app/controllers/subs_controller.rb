class SubsController < ApplicationController
    before_action :check_user, only:[:edit]
    before_action :require_logged_in?, only:[:show]
  def index
    @subs = Sub.all
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user
    if @sub.save
      redirect_to user_url(@sub.moderator_id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
        redirect_to sub_url(@sub)
    else
        flash.now[:errors] = @sub.errors.full_messages
        render :edit
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def show
    @sub = Sub.find(params[:id])
  end

  private
  def sub_params
    params.require(:sub).permit(:name, :description)
  end

  def check_user
    return if current_user.subs.find_by(id: params[:id])
        flash[:errors] = ['Not Your Sub!!!']
  end
end
