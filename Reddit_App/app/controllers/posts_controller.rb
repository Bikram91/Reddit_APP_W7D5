class PostsController < ApplicationController
  before_action :grab_post, only: [:edit, :update, :show]
  before_action :require_logged_in, except: [:show]
  before_action :confirm_author, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user
    @post.sub_id = params[:id]

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end

  def grab_post
    @post = Post.find(params[:id])
  end

  def confirm_author
    redirect_to post_url unless current_user.id == @post.author_id
  end
end
