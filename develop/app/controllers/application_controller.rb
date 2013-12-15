class ApplicationController < ActionController::Base
#protect_from_forgery
  before_filter :get_user
  def get_user
    if User.where(:token => session[:token]).last.nil?
      session[:token] = nil
      redirect_to :controller => 'user' , :action => 'login'
    end
  end
end
