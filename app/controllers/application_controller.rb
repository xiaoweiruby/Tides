require 'digest/md5'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :session_builder
  before_action :set_current_user

  def login
    render 'users/login'
  end

  def session_builder
    session[:current_path] = request.original_fullpath
  end

  def set_current_user
    if session[:user_id] && cookies[:token]
    @current_user = User.authenticate_token( session[:user_id], cookies[:token] )
    else
      @current_user = nil
    end
  end

  def require_login
    unless @current_user
      flash[:notice] = "你需要先登录才能访问那个页面。"
      session[:callback_url] = request.original_fullpath
      redirect_to login_url
    end
  end

  def require_privilege
    if @current_user.group.nil? || @current_user.group.id >1
      flash[:notice] = "对不起，这个区域你无权进入。"
      redirect_to @current_user
    end
  end

  def md5_hash( item )
    return Digest::MD5.hexdigest( item )
  end

end
