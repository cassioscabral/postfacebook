class SessionsController < ApplicationController

  def new
    redirect_to '/auth/facebook'
  end


  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'], 
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    user.add_role :admin if User.count == 1 # make the first user an admin
    if user.email.blank?
      redirect_to edit_user_path(user), :alert => "Please enter your email address."
    else
      @access_token = session[:omniauth]["credentials"]["token"]
      @graph = Koala::Facebook::API.new(@access_token)
      #profile = @graph.get_object("me")
      @graph.put_connections("me", "feed", :message => "mensagem de teste: Acabei de entrar no sistema") 

      redirect_to root_url, :notice => 'Signed in!'
    end

  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
