class PostsController < ApplicationController
  before_action :authorize_request
  before_action :find_post, except: %i[create index]

  # GET /posts
  def index
    @posts = Post.all.includes(:user, :likes)
    render json: @posts, status: :ok, each_serializer: PostAndUserSerializer
  end

  # # GET /posts/{id}
  # def show
  #   render json: post, status: :ok
  # end

  # POST /posts
  # def create
  #   post = Post.new(post_params)
  #   if post.save
  #     render json: post, status: :created
  #   else
  #     render json: { errors: post.errors.full_messages },
  #            status: :unprocessable_entity
  #   end
  # end

  # PUT /posts/{id}
  # def update
  #   #   if post.update(post_params)
  #   #     render json: post, status: :ok
  #   #   else
  #   #     render json: { errors: post.errors.full_messages },
  #   #            status: :unprocessable_entity
  #   #   end
  # end

  # DELETE /posts/{id}
  # def destroy
  #   #   post.destroy
  #   #   render status: :no_content
  # end

  private

  def find_post
    @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Post not found' }, status: :not_found
  end

  def post_params
    params.require(:post).permit(
      :user_id, :post
    )
  end
end
