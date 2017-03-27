module Read
  
  class PostsController < ReadController

    def index
      @posts = Post.most_recent.all
    end

    def show
      @post = Post.friendly.find(params[:id])
    end

  end

end