# Bot-Bot
[![Build Status](https://travis-ci.org/Baelor/bot-bot.svg?branch=master)](https://travis-ci.org/Baelor/bot-bot)
[![Dependency Status](https://gemnasium.com/Baelor/bot-bot.svg)](https://gemnasium.com/Baelor/bot-bot)
[![Code Climate](https://codeclimate.com/github/Baelor/bot-bot/badges/gpa.svg)](https://codeclimate.com/github/Baelor/bot-bot)

Bot-Bot is a bot for managing other IRC bots. Opers can manage a list of bots
which will be promoted to a certain oper class upon login. The goal is to avoid
having to add oper classes to ircd configuration for every bot and instead
allowing opers to manage the bots with commands. Tested with InspIRCd.

## Commands
### Management Commands (require OPER status)
`!delbot <authname>` - Delete access

`!listbots` - Get a list of all registered bots

`!regbot <nick>` - Register a new bot

`!resetbot <authname>` - Reset password

### Bot Commands     
`IDENTIFY <password>` - Login as a bot (in PRIVMSG)

## Installation

 1. Get Ruby (for example via [rbenv](https://github.com/rbenv/rbenv)). Tested 
    on Ruby 2.3
 2. Install bundler via `gem install bundler`
 3. Clone this repository and `cd` to your clone
 4. `cp config.yml.example config.yml` and modify the file as needed.
 5. Run `bundler install`
 6. Run `rake db:migrate`
 7. Start the bot with `ruby bot.rb`

## Upgrading
 1. Run `git pull` in your clone
 2. Proceed starting with installation step 5

## Maintenance
All user data is stored in `db/bot.db`. Include this file in your backups.
This is a simple sqlite database with one table.
