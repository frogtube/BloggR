class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authenticate_author!, only: [:author, :new, :edit, :create, :update, :destroy, :publish, :unpublish]
  
  PER_PAGE = 6

  # GET /posts
  # GET /posts.json
  def index
    if params[:tag].present?
      @posts = Post.published.most_recent.tagged_with([params[:tag]]).paginate(:page => params[:page], per_page: PER_PAGE)
    elsif params[:author_id].present?
      @posts = Post.published.most_recent.where(author_id: [params[:author_id]]).paginate(:page => params[:page], per_page: PER_PAGE)
    elsif params[:category_id].present?
      @posts = Post.published.most_recent.where(category_id: [params[:category_id]]).paginate(:page => params[:page], per_page: PER_PAGE)
    else  
      @posts = Post.published.most_recent.paginate(:page => params[:page], per_page: PER_PAGE)
    end
  end

  def author
    if params[:tag].present?
      @posts = current_author.posts.tagged_with([params[:tag]]).most_recent.paginate(:page => params[:page], per_page: PER_PAGE)
    else
      @posts = current_author.posts.most_recent.paginate(:page => params[:page], per_page: PER_PAGE)
    end
  end

  def publish
    @post = Post.find(params[:post])
    @post.update(published: true)
    if @post.published_at == nil
      @post.update(published_at: Time.now)
    end
    redirect_to author_path
  end

  def unpublish
    @post = Post.find(params[:post])
    @post.update(published: false)
    redirect_to author_path
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if author_signed_in? && current_author.id == Post.friendly.find(params[:id]).author.id
      @post = Post.all.friendly.find(params[:id])
    else
      @post = Post.published.friendly.find(params[:id])
    end
  end

  # GET /posts/new
  def new
    @post = current_author.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_author.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.jsonrails 
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to author_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_author
    redirect_to :back
  end

  def downvote
    @post = Post.friendly.find(params[:id])
    @post.downvote_by current_author
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_author.posts.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :content, :banner_image_url, :tag_list, :category_id)
    end
end
