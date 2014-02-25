class AdminController < ApplicationController
  before_filter :authenticate_account!
  
  def index
    @posts = Post.order("id desc").all
  end
  
end