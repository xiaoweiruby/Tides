class UsersController < ApplicationController
    before_action :require_login, only: [:index, :show, :edit, :update, :destroy]
    before_action :require_privilege, only:[:index, :destroy]
    before_action :set_user, only: [:show]
    before_action :check_user, only: [:edit, :update, :destroy]

    # GET /users
    # GET /users.json
    def index
        @users = User.all
    end

    #POST /login
    def login
        name = params[:user][:name]
        password = params[:user][:password]
        session[:login_error] = 0
        if @user = User.authenticate( name, password )
            session[:user_id] = @user.id
            session[:user_name] = @user.name
            token = cookies[:token] = md5_hash( "#{@user.id}#{Time.now}#{@user.email}")+md5_hash(request.user_agent)
            @user.sessions.create( active: 0, token: token, ip: request.remote_ip, useragent: request.user_agent )
            redirect_to( session[:callback_url] || @user, :notice => "欢迎回来， #{@user.name}")
        else
            session[:login_error] += 1
            flash[:notice] = "似乎出了些问题，再试试？"
            redirect_to login_url
        end
    end

  #GET /logout
  def logout
      reset_session
      @current_user = nil
      cookies.delete(:token)
      flash[:notice] = "您已经注销，记住常回来看看。"
      redirect_to login_url
  end

    # GET /users/1
    # GET /users/1.json
    def show
        redirect_to user_articles_path(@user) unless @user == @current_user
    end

    # GET /users/new
    def new
      @user = User.new
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users
    # POST /users.json
    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                format.html { redirect_to login_url, notice: '注册成功，可以登录了！' }
                format.json { render :show, status: :created, location: @user }
            else
                format.html { render :new }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to @user, notice: '所有的信息都已经更新。' }
            else
                format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_url, notice: '用户已删除。' }
            format.json { head :no_content }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find( params[:id] )
        end

        def check_user
            @user = @current_user.is_super_admin ? User.find( params[:id] ) : @current_user
        end

        def user_params
            params.require(:user).permit(:name, :telphone, :email, :username, :password, :password_confirmation )
        end
end
