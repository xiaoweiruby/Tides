class ArticlesController < ApplicationController
  before_action :require_login, only:[:new, :edit, :create, :update, :destroy]
  before_action :set_categories
  before_action :set_article, only:[:show, :edit, :update, :destroy]
  before_action :check_article_user, only:[:edit, :update, :destroy]

  # GET /articles
  def index
    if params[:user_id]
      @user = User.find( params[:user_id] )
      @articles = @user.articles.order(created_at: :desc).page params[:page]
    else
      @articles = Article.all.order(created_at: :desc).page params[:page]
    end
  end

  def latest
    @articles = Article.last(10).reverse
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
   @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.user = @current_user
    @article.category = Category.find( @article.category_id )
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: '发布成功。' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: '更新成功。' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
    if @current_user
      @edit_tag = @article.user == @current_user || @current_user.is_super_admin
    else
      @edit_tag = false
    end
  end

  def set_categories
    @categories = []
    Category.all.each do |category|
      @categories.push( ["#{category.name}","#{category.id}"] )
    end
  end

  def check_article_user
    redirect_to @article unless @article.user == @current_user || @current_user.is_super_admin
  end

  def article_params
    params.require(:article).permit(:title, :category_id, :content, :page )
  end

end
