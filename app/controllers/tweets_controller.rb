class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order(created_at: :desc).limit(10)
    @tweet = Tweet.new
    @users = User.all # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
      if @tweet.save
        flash[:notice] = "Tweet successfully"
        redirect_to tweets_path
      else
        flash[:alert] = "Fail to tweet"
        redirect_to tweets_path(@tweet)
      end
  end

  def like
    @tweet= Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_to tweets_path
  end

private
  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
