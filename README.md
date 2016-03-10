# mtg-geckoboard
Coveralls, Travis and MTG push API for my Geckoboard

##Intro

This repo contains everything related to my personal Geckoboard – scripts to collect and format data from cardkingdom.com, Coveralls, and Travis-CI, a "pusher" to send JSON data to Geckoboard, and a stylesheet.

##About

Each script interfaces with a different type of Geckoboard widget. Each script fetches some data, formats it properly, then pushes it to the relevant widget URI. As all of my projects are open source the only required API key is for Geckoboard itself.

The Travis script is a simple text widget which displays the current state of the most recent Travis build from my trosborn/pagliacci Github repo.

The Coveralls script displays the current test coverage for the most recent build of the master branch of trosborn/pagliacci using a Gecko-o-Meter.

The Pricer takes a CSV of Magic card names and editions and uses the Scraper to find the associated near-mint card price on cardkingdom.com. Then it sorts the prices high to low, and pushes it up to a leaderboard widget.
##Usage

Each script interfaces with the Pusher#create_agent method in Pusher.rb. This method takes two arguments – a properly formatted JSON object, and the complete URI for your widget

First, you must set up your API key. The easiest and most secure way is to set 'GECKOBOARD_API_KEY' in your IRB window:

```
ENV['GECKOBOARD_API_KEY'] = 'a4751ee675c35183a1922dd536a935a47'
```

Now we can run the relevant scripts. To run the Travis or Coveralls scripts, simply load the files into IRB:

```
load 'travis.rb'
load 'coveralls.rb'
```

IRB will print out the response from Geckoboard. If the response is anything other than "{"success":true}" something went wrong.

##MTG Card Pricer
The MTG card pricer takes a CSV of MTG cards and scrapes cardkingdom.com for the NM price of the relevant edition.

To run the MTG Card Pricer, you'll first need to fill out a CSV file in the following format:

```
Name,Edition,Quanity,Language
```
And then set the 'CARDS_CSV_PATH' env variable to the path for the CSV.

About the CSV: Name and Edition are required fields. Quantity and Language are optional. I've included the CSV I use for my cards as an example in the root directory of this repo.

