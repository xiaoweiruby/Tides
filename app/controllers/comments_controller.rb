class CommentsController < ApplicationController
    before_action :require_privilege, only:[:index]
    before_action :set_comment, only: [:show, :edit, :update, :destroy]
    before_action :check_comment, only: [:edit, :update, :destroy]

    # GET /comments
    def index
        if @current_user
          if @current_user.is_super_admin
            @comments = Comment.all
          else @current_user
            @comments = @current_user.comments
          end
        else
          redirect_to articles_path
        end
    end

    # GET /comments/1
    def show
    end

    def new
        @comment = Comment.new
    end

    # GET /comments/1/edit
    def edit
    end

    # POST /comments
    def create
        @article = Article.find( params[:article_id] )
        @current_user.comments.create(comment_params)
        redirect_to article_path(@article)
    end

    # PATCH/PUT /comments/1
    def update
        respond_to do |format|
            if @comment.update(comment_params)
                format.html { redirect_to @article }
                #format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
            else
                format.html { render :edit }
            end
        end
    end

  # DELETE /comments/1
  def destroy
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article)
  end

  private
    def set_comment
        @comment = Comment.find(params[:id])
        @article = @comment.article
    end

    def check_comment
        redirect_to articles_path if @comment.user != @current_user && @comment.user.is_super_admin
    end

    def comment_params
        params.require(:comment).permit( :article_id, :tool_id, :comment_id, :content )
    end
end
