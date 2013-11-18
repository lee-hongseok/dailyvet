#encoding:utf-8
class JobController < ApplicationController
  layout 'job_layout'
  def index
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
    final = JobPost.last.id - (@page_number-1)*10
    initial = final - 10
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
  end
  def write_process
    jp = JobPost.new

    jp.user_id = session[:id]
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
    redirect_to :action => 'index' 
  end

  def detail
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
    @post = JobPost.find(params[:id]) #업데이트 할 글을 뽑아옵시다.
  end


  def update_process #write_process랑 크게 다르지 않습니다.
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
    if params[:id] == session[:id]
      post = Post.find(params[:id])
      post.delete_flag = true
      post.save
      redirect_to :action => 'index' 
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
end