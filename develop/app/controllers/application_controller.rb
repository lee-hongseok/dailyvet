class ApplicationController < ActionController::Base
#protect_from_forgery
  before_filter :get_user
  def get_user
    unless User.where(:id => session[:id]).last.nil?
      user_name = User.where(:id => session[:id]).last.name
      if user_name == session[:name]
        
      else
        session[:id] = nil
        session[:name] = nil
        redirect_to :controller => 'user' , :action => 'login'
      end
    else
      session[:id] = nil
      session[:name] = nil
      redirect_to :controller => 'user' , :action => 'login'
    end
  end
end
