class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]

  def index
    @users = User.all
  end

    def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end


def show
  @access_token = session[:omniauth]["credentials"]["token"]
  @user = User.find(params[:id])
  @graph = Koala::Facebook::API.new(@access_token)
  profile = @graph.get_object("me")
  friends = @graph.get_connections("me", "friends")
  
  
  end

end
