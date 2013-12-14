#encoding: utf-8
class UserController < ApplicationController
skip_before_filter :get_user
  def login
    unless session[:id].nil?
      redirect_to :controller => 'community' , :action => 'all'
    else
      render :layout => 'other_layout'
    end
  end
  
  def login_process
    u=User.where(:user_id =>params[:user_id]).last
    if u.nil?
       render :text =>"아이디 및 비밀번호가 틀렸습니다."
    elsif  u.password == Digest::SHA512.hexdigest(params[:password])
      unless u.exit_flag == true
        if u.level == 0 
          session[:name] = u.name  
          session[:user] = "DAILYVETadminDAILYVET"
          session[:token] = u.token
          session[:id] = u.id  
          if session[:bbs] = 0
            redirect_to :controller => 'community' , :action => 'all'
          elsif session[:bbs] = 1
            redirect_to :controller => 'job' , :action =>'all'
          end
        else
          session[:name] = u.name  
          session[:id] = u.id  
          session[:token] = u.token
          session[:view_check] = []
          if session[:bbs] = 1
            redirect_to :controller => 'job' , :action =>'all'
          elsif session[:bbs] = 0
            redirect_to :controller => 'community' , :action => 'all'
          end
        end
      else
        render :text => "탈퇴한 회원입니다."
      end
    else
      render :text => "아이디 및 비밀번호가 틀렸습니다."
    end
  end
  def modify
    @user = User.where(:token => session[:token]).last
  end
  def logout
    session[:user] = nil
    session[:id] = nil
    session[:name] = nil
    session[:token] = nil
    redirect_to :action => 'login'
  end

  def sign_up
      render :layout => "sign_up_layout"
  end

  def sign_up_process
  if User.where(:user_id => params[:user_id]).count == 0
    if params[:password] == params[:password_confirm]
      u = User.new
      u.email = params[:email]
      u.password = Digest::SHA512.hexdigest(params[:password])
      u.name = params[:name]
      u.nickname = params[:nickname]
      u.user_id = params[:user_id]
      u.phone_number = params[:phone_number]
      u.city = params[:city]
      u.county = params[:county]
      u.field = params[:field]
      u.vet_number = params[:vet_number]
      u.student_number = params[:student_number]
      u.work_name = params[:work_name]
      u.work_number = params[:work_number]
      u.university = params[:university]
      u.mail_receive = params[:mail_receive]
      u.sms_receive = params[:sms_receive]
      u.make_token
      u.level = 1
      u.exit_flag = false
      u.save
      redirect_to :controller => 'user', :action => 'login'
    else
      render :text => "비밀번호가 일치하지 않습니다."
    end
  else
    render :text => "이미 사용되고 있는 아이디입니다."
  end
  end
#
  def sign_modify
      u = User.find(session[:id])
      @session_html = session[:id]
      @email = u.email
      @name = u.name
  end
#
  def sign_modify_process
    if params[:password_html] == params[:password_confirm_html]  
    puts params[:id_html]
      u = User.find(params[:id_html])
      u.password = Digest::SHA512.hexdigest(params[:password_html])
      u.name = params[:name_html]
      u.save
      session[:user] = User.find(session[:id]).name
      render :action => 'login'
    else
      render :text => "비밀번호가 일치하지 않습니다."
    end
  end

  def sign_out
  end

  def sign_out_process
    session[:user] = nil
    session[:id] = nil
    u = User.where(:id => session[:id]).first
    u.exit_flag = false
    u.save
    redirect_to :action => 'login'
  end

  def where_is_my_id
  end
  
  def where_is_my_id_process
    u = User.where(:name => params[:name_html]).first
    @my_id = u.email
  end

  def where_is_my_password
  end

  def where_is_my_password_process
    temp = (1..45).to_a.sample(6).sort
    temp = temp.join
    u=User.where(:email=> params[:email_html]).first
    gmail = Gmail.connect("jang2poom@gmail.com","sinclair09")
    gmail.deliver do
      to u.email
      subject u.name+"님 비밀번호 변경 안내 메일입니다."
      text_part do
        body "임시비밀번호는" + temp +"입니다."
      end
    end
    u=User.where(:email=> params[:email_html]).first
    u.password = Digest::SHA512.hexdigest(temp)
    u.save
    gmail.logout
    render :text =>"메일로 임시비밀번호가 발송되었습니다"
  end
  
  def admin_ok
    if session[:user] == "DAILYVETadminDAILYVET"
      find = params[:find]
      if find =="0"
        @user = User.where(:field =>0 ).all
      elsif find =="1"
        @user = User.where(:field => 1).all
      elsif find =="2"
        @user = User.where(:field => 2).all
      elsif find =="3"
        @user = User.where(:field => 3).all
      elsif find =="4"
        @user = User.where(:field => 4).all
      elsif find =="5"
        @user = User.where(:field => 5).all
      elsif find =="6"
        @user = User.where(:field => 6).all
      elsif find =="7"
        @user = User.where(:field => 7).all
      elsif find =="8"
        @user = User.where(:field => 8).all
      elsif find =="9"
        @user = User.where(:field => 9).all
      elsif find =="10"
        @user = User.where(:field => 10).all
      elsif find =="11"
        @user = User.where(:field => 11).all
      elsif find =="12"
        @user = User.where(:field => 12).all
      else
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        @user = User.all
      end
    else
      render :text => "잘못된 접근입니다."
    end
  end

  def detail
    if session[:user] == "ADMIN"
      @user = User.where(:id =>params[:id]).last
    else
      render :text => "잘못된 접근입니다."
    end
  end

  def level_modify
    if session[:user] == "ADMIN"
      user = User.find(params[:id])
      if params[:level].nil?
        render :text => "등급값이 비어있습니다. "
      else
        user.level = params[:level]
        user.save
      end
    else
      render :text => "잘못된 접근입니다."
    end
  end
  def pre_sign_up
      render :layout => "sign_up_layout"
  end

end
