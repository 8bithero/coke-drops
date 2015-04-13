class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
  end

  def create
    response   = Tweet.get_new_tweets
    new_tweets = JSON.parse(response.body)

    if response.code == 200 && Tweet.save_tweets(new_tweets)
      # flash[:success] = "Gotcha! #{response.code} #{response.body}"
      flash[:success] = "Gotcha! Messages received!"
      redirect_to root_url
      
    elsif response.code == 500
      # raise response.inspect
      flash[:danger] = "Aw shucks! Something went wrong - Please try again."
      render :index

    end
  end
  

  def reset
    Tweet.destroy_all
    redirect_to root_url
  end
end
