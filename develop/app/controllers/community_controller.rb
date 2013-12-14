#encoding:utf-8
class CommunityController < ApplicationController
skip_before_filter :get_user , :only => [:index]
  def index
    session[:bbs] = 0
    redirect_to :action => 'all'
  end
  def all
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
    final = Post.last.id - (@page_number-1)*10
    initial = final - 9
    puts final
    puts initial
#   initial = @page_number*20-19
#    final = @page_number*20
    #한페이지에는 10개씩의 글
#@posts = Post.where(:delete_flag => false, :id => initial..final).all
    @posts = Post.where(:id => initial..final).all.reverse
    @users = User.all
    @comments = Comment.all
    @notice = Post.where(:category =>0).all.reverse
  end

  def write
    user = User.where(:token => session[:token]).last
    if user.level ==1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    
  end

  def write_process
    user = User.where(:token => session[:token]).last
    if user.level ==1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    post = Post.new

    post.user_id = session[:id]
    post.title = params[:title_from_view]
    post.content = params[:content_from_view]
    post.category = params[:category_from_view]
    post.anomynous_flag = params[:anomynous_flag]
    post.notice_flag = params[:notice_flag]
    post.save                 
    redirect_to :action => 'all' 
  end

  def detail
    user = User.where(:token => session[:token]).last
    if user.level ==1
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
    @clicked_post = Post.where(:id => params[:id]).last
    if session[:view_check].index(@clicked_post.id).nil?
      session[:view_check] << @clicked_post.id
      @clicked_post.counter += 1
      @clicked_post.save
    end
    puts @page_number
    final = Post.last.id - (@page_number-1)*10
    initial = final - 9
    #한페이지에는 20개씩의 글
#@posts = Post.where(:delete_flag => false, :id => initial..final).all
    @posts = Post.where(:id => initial..final).all.reverse
    @users = User.all
    @notice = Post.where(:category =>0).all.reverse
  end

  def update
    user = User.where(:token => session[:token]).last
    if user.level ==1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    @post = Post.find(params[:id]) #업데이트 할 글을 뽑아옵시다.
  end


  def update_process #write_process랑 크게 다르지 않습니다.
    user = User.where(:token => session[:token]).last
    if user.level ==1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
      post = Post.find(params[:id])
    if post.user_id == session[:id]
      post.title = params[:title_from_view]
      post.content = params[:content_from_view]
      post.notice_flag = params[:notice_flag]
      post.category = params[:category_from_view]
      post.save

      redirect_to :action => 'all' 
    else 
      render :text => "잘못된 접근입니다"
    end
  end

  def reply_process
    user = User.where(:token => session[:token]).last
    if user.level ==1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
      reply = Comment.new
      reply.post_id = params[:post_id_from_view]
      reply.user_id = session[:id]
      reply.content = params[:reply_content_from_view]
      reply.anomynous_flag = params[:anomynous_flag]
      reply.save
      post_id = params[:post_id_from_view]
      page_number = params[:page_from_view]
      redirect_to :action => 'detail' , :id => post_id , :page => page_number
  end

  def delete_post
    user = User.where(:token => session[:token]).last
    if user.level ==1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    post = Post.find(params[:id])
    if post.user_id == session[:id]

    post.delete_flag = true
    post.save
    redirect_to :action => 'all' 
    else
      render :text => "잘못된 접근입니다"
    end
  
  end
  def vote
    user = User.where(:token => session[:token]).last
    if user.level ==1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    user = User.where(:id => session[:id]).last
    if user.voted_posts.where(:post_id => params[:post_id].to_i).last.nil? 
      post = Post.where(:id => params[:post_id]).last
      voted_post = user.voted_posts.new
      if params[:which].to_i == 1
        user = User.where(:id => session[:id]).last
        post.vote_up += 1
        voted_post.post_id = params[:post_id]
        voted_post.which = params[:which]
        post.save
        voted_post.save
        post = Post.where(:id => params[:post_id]).last
        data = {:message => 1}
        render :json => data.to_json
=begin
여기서 데이터 메세지 정리
1 = 추천되었습니다
2 = 비추천되었습니다
3 = 이미 추천하셨습니다
4 = 이미 비추천하였습니다
=end
      elsif params[:which].to_i == -1
        user = User.where(:id => session[:id]).last
        post.vote_down += 1
        voted_post.post_id = params[:post_id]
        voted_post.which = params[:which]
        post.save
        voted_post.save
        post = Post.where(:id => params[:post_id]).last
        data = {:message => 2}
        render :json => data.to_json
      end
    elsif user.voted_posts.where(:post_id => params[:post_id].to_i).last.which == 1
        post = Post.where(:id => params[:post_id]).last
        data = {:message => 3}
        render :json => data.to_json
    elsif user.voted_posts.where(:post_id => params[:post_id].to_i).last.which == -1
        post = Post.where(:id => params[:post_id]).last
        data = {:message => 4}
        render :json => data.to_json
    end         
  end
  
  def comment_vote
    user = User.where(:token => session[:token]).last
    if user.level ==1
      flash[:notice] = "인증과정이 진행중입니다"
      redirect_to :action => 'all'
    end
    user = User.where(:id => session[:id]).last
    if user.voted_comments.where(:comment_id => params[:comment_id].to_i).last.nil? 
      comment = Comment.where(:id => params[:comment_id]).last
      voted_comment = user.voted_comments.new
      if params[:which].to_i == 1
        user = User.where(:id => session[:id]).last
        comment.vote_up += 1
        voted_comment.comment_id = params[:comment_id]
        voted_comment.which = params[:which]
        comment.save
        voted_comment.save
        comment = Comment.where(:id => params[:comment_id]).last
        data = {:message => 1}
        render :json => data.to_json
=begin
여기서 데이터 메세지 정리
1 = 추천되었습니다
2 = 비추천되었습니다
3 = 이미 추천하셨습니다
4 = 이미 비추천하였습니다
=end
      elsif params[:which].to_i == -1
        user = User.where(:id => session[:id]).last
        comment.vote_down += 1
        voted_comment.comment_id = params[:comment_id]
        voted_comment.which = params[:which]
        comment.save
        voted_comment.save
        comment = Comment.where(:id => params[:comment_id]).last
        data = {:message => 2}
        render :json => data.to_json
      end
    elsif user.voted_comments.where(:comment_id => params[:comment_id].to_i).last.which == 1
        comment = Comment.where(:id => params[:comment_id]).last
        data = {:message => 3}
        render :json => data.to_json
    elsif user.voted_comments.where(:comment_id => params[:comment_id].to_i).last.which == -1
        comment = Comment.where(:id => params[:comment_id]).last
        data = {:message => 4}
        render :json => data.to_json
    end         
  end
  def temp
  end
end
