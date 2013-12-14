#encoding:utf-8
class JobController < ApplicationController
skip_before_filter :get_user , :only => [:index]
  def index
    session[:bbs] = 1
    redirect_to :action => "all"
  end
  def all
    @action_name = "index"
    @page_number = params[:page].to_i
    if @previous == 0 
      @previous =1
    end
    if @page_number < 10
      @previous = 0
    else
        temp = @page_number -1
        @previous = temp.to_s[0..-2].to_i
    end
    if @page_number == 0
      @page_number=1
    end
    final = JobPost.count - (@page_number-1)*10
    initial = final - 9
    puts final
    puts initial
    puts "hasjdfasfhldfasdhflkasasdhfkafjklsddfhasdkasdjklfhasld"
#   initial = @page_number*20-19
#    final = @page_number*20
    #한페이지에는 10개씩의 글
#@posts = Post.where(:delete_flag => false, :id => initial..final).all
    @posts = JobPost.where(:id =>initial..final).reverse
    @users = User.all
    @comments = Comment.all
    @notice = JobPost.where(:category =>0).all.reverse
  end
  def write
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
  end
  def write_process
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    jp = JobPost.new

    jp.user_id = session[:id]
    jp.category = params[:category]
    jp.each = params[:each]
    jp.hour = params[:hour]
    jp.name = params[:name]
    jp.city = params[:city]
    jp.county = params[:county]
    jp.address_detail = params[:address_detail]
    jp.to = params[:to]
    jp.pay = params[:pay]
    jp.qualification = params[:qualification]
    jp.experience = params[:experience]
    jp.favorite = params[:favorite]
    jp.tel = params[:tel]
    jp.hp = params[:hp]
    jp.method = params[:method]
    jp.dead_line = params[:dead_line]
    jp.detail = params[:detail]
    jp.title = params[:title]
    jp.notice_flag = params[:notice_flag]
    jp.save                 
    redirect_to :action => 'all' 
  end

  def detail
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    @page_number = params[:page].to_i
    if @previous == 0 
      @previous =1
    end
    if @page_number < 10
      @previous = 0
    else
        temp = @page_number -1
        @previous = temp.to_s[0..-2].to_i
    end
    if @page_number == 0
      @page_number=1
    end
    @clicked_post = JobPost.where(:id => params[:id]).last
    jp_matcher = 0 - @clicked_post.id
    if session[:view_check].index(jp_matcher).nil?
      session[:view_check] << jp_matcher 
      @clicked_post.counter += 1
      @clicked_post.save
    end
    puts @page_number
    final = JobPost.last.id - (@page_number-1)*10
    initial = final - 10
    #한페이지에는 20개씩의 글
#@posts = Post.where(:delete_flag => false, :id => initial..final).all
    @posts = JobPost.where(:id => initial..final).all.reverse
    @notice = JobPost.where(:category =>"공지").all.reverse

  end

  def update
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    @post = JobPost.find(params[:id]) #업데이트 할 글을 뽑아옵시다.
  end


  def update_process #write_process랑 크게 다르지 않습니다.
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    if params[:id] == session[:id]

      jp = JobPost.find(params[:id])
      jp.category = params[:category]
      jp.each = params[:each]
      jp.hour = params[:hour]
      jp.name = params[:name]
      jp.address = params[:address]
      jp.to = params[:to]
      jp.pay = params[:pay]
      jp.qualification = params[:qualification]
      jp.experience = params[:experience]
      jp.favorite = params[:favorite]
      jp.tel = params[:tel]
      jp.hp = params[:hp]
      jp.method = params[:method]
      jp.dead_line = params[:dead_line]
      jp.detail = params[:detail]
      jp.title = params[:title]
      jp.notice_flag = params[:notice_flag]
      jp.save                 
      
      redirect_to :action => 'detail' , :id =>params[:id], :page =>params[:page_number]
    else
      render :text => "잘못된 접근입니다."
    end
  end

  def delete_post
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    if params[:id] == session[:id]
      post = Post.find(params[:id])
      post.delete_flag = true
      post.save
      redirect_to :action => 'all' 
    else
      render :text => "잘못된 접근입니다"
    end
  end
  def reply_process
      reply = Comment.new
      reply.job_post_id = params[:job_post_id_from_view]
      reply.user_id = session[:id]
      reply.content = params[:reply_content_from_view]
      reply.save
      jp_id = params[:job_post_id_from_view]
      page_number = params[:page_from_view]
      redirect_to :action => 'detail' , :id => jp_id , :page => page_number
  end
  def companion
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    @action_name = "companion"

    @page_number = params[:page].to_i
    if @page_number < 10
      @previous = 0
    else
        @previous = temp.to_s[0..-2].to_i
    end
    if @page_number == 0
      @page_number=1
    end
    final = JobPost.where(:category => "반려동물임상").count - (@page_number-1)*10
    initial = final - 9
    if initial < 1
      initial = 1
    end
    if final < 1 
      @posts = JobPost.where(:id => 0).last
    else
      @posts = JobPost.where(:category => "반려동물임상")[initial-1 .. final-1].reverse
    end
    @notice = JobPost.where(:category =>0).all.reverse

  end

  def domestic
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    @action_name = "domestic"
    @page_number = params[:page].to_i
    if @page_number < 10
      @previous = 0
    else
        @previous = temp.to_s[0..-2].to_i
    end
    if @page_number == 0
      @page_number=1
    end
    final = JobPost.where(:category => "산업동물임상").count - (@page_number-1)*10
    initial = final - 9
    if initial < 1
      initial = 1
    end
    if final < 1 
      @posts = JobPost.where(:id => 0).last
    else
      @posts = JobPost.where(:category => "산업동물임상")[initial-1 .. final-1].reverse
    end
    @users = User.all
    @comments = Comment.all
    @notice = JobPost.where(:category =>0).all.reverse

  end

  def public
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end

    @action_name = "public"
    @page_number = params[:page].to_i
    if @page_number < 10
      @previous = 0
    else
        @previous = temp.to_s[0..-2].to_i
    end
    if @page_number == 0
      @page_number=1
    end
    final = JobPost.where(:category => "공무원").count - (@page_number-1)*10
    initial = final - 9
    if initial < 1
      initial = 1
    end
    if final < 1 
      @posts = JobPost.where(:id => 0).last
    else
      @posts = JobPost.where(:category => "공무원")[initial-1 .. final-1].reverse
    end
    @users = User.all
    @comments = Comment.all
    @notice = JobPost.where(:category =>0).all.reverse
  end

  def general
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    @action_name = "general"
    @page_number = params[:page].to_i
    if @page_number < 10
      @previous = 0
    else
        @previous = temp.to_s[0..-2].to_i
    end
    if @page_number == 0
      @page_number=1
    end
    final = JobPost.where(:category => "일반업체").count - (@page_number-1)*10
    initial = final - 9
    if initial < 1
      initial = 1
    end
    if final < 1 
      @posts = JobPost.where(:id => 0).last
    else
      @posts = JobPost.where(:category => "일반업체")[initial-1 .. final-1].reverse
    end
    @users = User.all
    @comments = Comment.all
    @notice = JobPost.where(:category =>0).all.reverse
  end

  def etc
    user = User.where(:token => session[:token]).last
    if user.level == 1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    @action_name = "etc"
    @page_number = params[:page].to_i
    if @page_number < 10
      @previous = 0
    else
        @previous = temp.to_s[0..-2].to_i
    end
    if @page_number == 0
      @page_number=1
    end
    final = JobPost.where(:category => "기타").count - (@page_number-1)*10
    initial = final - 9
    if initial < 1
      initial = 1
    end
    if final < 1 
      @posts = JobPost.where(:id => 0).last
    else
      @posts = JobPost.where(:category => "기타")[initial-1 .. final-1].reverse
    end
    @users = User.all
    @comments = Comment.all
    @notice = JobPost.where(:category =>0).all.reverse
  end

end
