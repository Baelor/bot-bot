require 'cinch'
require './lib/settings'
require './lib/db'
require './lib/models/bots'
require 'terminal-table'

# List all bots in the DB
class ListBots
  include Cinch::Plugin
  include PluginUtils

  match /listbots/i

  def execute(m)
    unless authorized?(m.user)
      warn "Received !listbots command from unauthorized user #{m.user.nick}"
      m.reply 'Permission denied. This command is only available to opers.'
      return
    end

    headings = ['Authname', 'Added at', 'By', 'Last Login',
                'Last Login Nick', 'Online?']
    table = Terminal::Table.new headings: headings, rows: bot_list
    m.reply table
  end

  private

  def bot_list
    bots = []
    Bots.each do |b|
      online = if b.last_login_nick.nil?
                 'No'
               elsif bot.user_list.find_ensured(b.last_login_nick).online?
                 'Yes'
               else
                 'No'
               end

      bots << [
        b.authname,
        b.added_at,
        b.added_by,
        b.last_login,
        b.last_login_nick,
        online
      ]
    end
    bots
  end
end
