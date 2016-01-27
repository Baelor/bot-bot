require 'cinch'
require './lib/settings'
require './lib/db'
require './lib/plugin_utils'
require './lib/models/bots'

# Delete a bot from the DB and drop its privileges
class DeleteBot
  include Cinch::Plugin
  include PluginUtils

  match /delbot (.*)?/i

  def execute(m, authname)
    authname.strip!

    unless authorized?(m.user)
      warn "Received !delbot command from unauthorized user #{m.user.nick}"
      m.reply 'Permission denied. This command is only available to opers.'
      return
    end

    db_bot = Bots.first(authname: authname)

    if db_bot.nil?
      m.reply "Couldn't find bot with authname #{authname}"
      return
    end

    if db_bot.last_login_nick &&
       bot.user_list.find_ensured(db_bot.last_login_nick).online?
      m.bot.irc.send("SAMODE #{db_bot.last_login_nick} -oB")
    end

    db_bot.destroy
    info "Deleted bot #{authname}"
    m.reply "#{authname} was deleted successfully"
  end
end
