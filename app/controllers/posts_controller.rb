class PostsController < ApplicationController
  # before_action メソッド名で only 指定した各アクションの前にメソッドを実行する
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.order(id: :asc)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # notice: "投稿しました"←フラッシュメッセージ flash[:notice] = "投稿しました"と同じ意味
    if @post.save
      redirect_to post_path(post), notice: '投稿しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to root_path, notice: '更新しました'
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to root_path, notice: '削除しました'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
