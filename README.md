# CokeDrops - Adaptive Lab Test

##Introduction
The app has been build as part of the Adaptive Lab test. It has been built using Ruby On Rails v4.2.1 running on Ruby v2.1.5 and Capybara & RSPEC for testing. 
App is best viewed using the latest version of Firefox or Chrome.

A working demo of the app can be found at http://coke-drops.herokuapp.com

#### Features
- Message Filtering is done by clicking the colour drops.
- Censored words can be highlighted by ticking the checkbox.
- All messages can be deleted by clicking the `Reset DB` link.

##Requirements
- Build a webapp that consumes tweets all about "Coke".
- Messages containing one or more of the following keywords should be highlighted in red: ‘coke’, ‘coca-cola’ and ‘diet cola’.
- The information to be shown for each message should be the user’s handle, the message text and the sentiment.
- The messages should be sorted by sentiment, in descending order.
- The messages should not be duplicated - instead, display a counter that tells the user how many times that message has been seen.
- The API might fail occasionally so your app should account for that and display some sort of message to the user.

####Optinal Requirements
- When a user clicks on a user handle, another view is displayed, which shows all of the messages from that particular user.
- Instead of displaying the sentiment number, display the sentiment as a happy, sad or neutral face.


##Setup & Configuration

```
$ bundle install
$ rake db:create db:migrate
```

##Starting the application

```
$ rails s
```

## Using the application

To view messages all about Coke, visit the messages page at /messages/index.
Application testing

This application is covered by automated tests written using Capybara and RSpec.


### Running tests with RSpec

```
$ bundle exec rspec
```