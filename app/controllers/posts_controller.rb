class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authenticate_author!, only: [:author, :new, :edit, :create, :update, :destroy, :publish, :unpublish]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.most_recent.published.paginate(:page => params[:page], per_page: 3)
  end

  def author
    @posts = current_author.posts.most_recent.paginate(:page => params[:page], per_page: 3)
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
    @post = Post.all.friendly.find(params[:id])
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
  # PATCH/PUT /posts/1.json
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_author.posts.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :content, :banner_image_url, :tag_list)
    end
end
