class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_member!, except: [:index, :show]

  def index
    @posts = Post.all
    @post = Post.new
  end

  def new
   @post = current_member.posts.build
  end

 
  def create
    @post = current_member.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body)
    end
end
