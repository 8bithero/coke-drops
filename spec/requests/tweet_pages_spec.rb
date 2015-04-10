require 'spec_helper'

describe "Tweet pages" do

  subject { page }

  describe "index" do
    before { visit root_path }
    
    it { should have_title('CokeDrops') }
    # it { should have_content('Coke Drops') }

    describe "message list" do
      before(:all) do
        FactoryGirl.create_list(:tweet, 5)
        @tweet = Tweet.first
      end
      after(:all) { Tweet.delete_all }
      it { should have_selector('div.list-group') }
      it "should list each message" do
          expect(page).to have_selector('a.list-group-item', count: 5)
      end
    end

    describe "empty message list" do
      it { should_not have_selector('a.list-group-item') }
    end
  end

  describe "fetching tweets (:create)" do
    before { visit root_path }

    

    describe "with error - status: 500" do
      # before {click_link "Fetch more messages" }
      it "should not create a tweet" do

        # stub_request(:get, "http://adaptive-test-api.herokuapp.com/tweets.json").
        # with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'adaptive-test-api.herokuapp.com', 'User-Agent'=>'Ruby'}).
        # to_return(:status => 200, :body => "", :headers => {})
        # expect(WebMock).to have_requested(:get, "http://adaptive-test-api.herokuapp.com/tweets.json").
        #   with(:body => [{
        #                   created_at:"2012-09-27T16:18:50Z",
        #                   followers:245,
        #                   id:14,
        #                   message:"Coke coke coke coke coke!!!!",
        #                   sentiment:0.4,
        #                   updated_at:"2012-09-27T16:18:50Z",
        #                   user_handle:"@coke_snortr"
        #                 },
        #                 {
        #                   created_at:"2012-09-27T16:18:09Z",
        #                   followers:3,
        #                   id:13,
        #                   message:"I've got to say - Pepsi max is great!",
        #                   sentiment:0.9,
        #                   updated_at:"2012-09-27T16:18:09Z",
        #                   user_handle:"@tasteless"
        #                 }],
        #     :headers => {'Content-Type' => 'application/json'})
        
        # expect { click_link "Fetch more messages" }.not_to change(Tweet, :count)
      end

      # describe "error messages" do
      #   before { click_button "Fetch more messages" }
      #   it { should have_content('error') }
      # end
    end

    describe "without error - status: 200" do

      it "returns data" do
        stub_request(:get, "adaptive-test-api.herokuapp.com/tweets.json").to_return(:status => [200, "OK"])
        puts HTTParty.get "http://adaptive-test-api.herokuapp.com/tweets.json"
      end

      # # before { fill_in 'micropost_content', with: "Lorem ipsum" }
      # it "should create two tweets" do
      #   expect { click_button "Fetch more messages" }.to change(Tweet, :count).by(2)
      # end

      # context "duplicate message" do
      #   describe "only one message is a duplicate" do
      #     before do
      #       FactoryGirl.create_list(:tweet, 2)
      #       @tweet = Tweet.first
      #     end
      #     expect { click_button "Fetch more messages" }.to change(Tweet, :count).by(1)
      #     expect { click_button "Fetch more messages" }.to change(Tweet.counter).by(1)
      #   end

      #   describe "both messages are duplicates" do
      #   end
      # end
    end
  end
end