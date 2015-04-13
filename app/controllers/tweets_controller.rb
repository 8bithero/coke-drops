class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all#.order(sentiment: :desc)
    @filters = { positive: 1, neutral: 1, negative: 1}
    # @tweet = Tweet.new
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
      flash[:danger] = "Aw shucks! Something went wrong - Please try again."
      render :index

    end
  end

  # def update_tweet_list
  #   @tweets = Tweet.first
  #   respond_to do |format|
  #     format.html { redirect_to tweets_path, notice: 'Tweets filtered.' }
  #     format.json
  #   end
  # end


  def update_list

    # @selected = Item.where(:category_id => params[:cat_id])
    # @selected = [1,2,3,4]
    # if @tweets = Tweet.all
    # raise params[:filters]["positive"].inspect

    # @filters = params[:filters]["#{params[:change]}"].inspect
      @hello = "hi"
      @msg = "helllooooo111"
      # @selected = Tweet
      @selected = Tweet.all

      if params[:show] == "positive"
        @selected = Tweet.positive

      elsif params[:show] == "neutral"
        @selected = Tweet.neutral

      elsif params[:show] == "negative"
        @selected = Tweet.negative

      end
          

      # raise @selected.inspect
      # case params[:state]
      #   when "positive"
      #     raise "a"
      #   when "y"
      #     raise "b"
      # end
      respond_to do |format|
         format.js
      end

  end

  def foobar
    @myvar = "MyVarTest"
    raise "hello"
     respond_to do |format|
       format.js {}
     end
  end

    # render :index, tweet = Tweet.first
  

  def reset
    Tweet.destroy_all
    redirect_to root_url
  end
end
