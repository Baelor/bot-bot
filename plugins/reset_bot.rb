require 'cinch'
require './lib/settings'
require './lib/db'
require './lib/plugin_utils'
require './lib/models/bots'

# Reset a bot's password
class ResetBot
  include Cinch::Plugin
  include PluginUtils

  match /resetbot (.*)?/i

  def execute(m, authname)
    authname.strip!

    unless authorized?(m.user)
      warn "Received !resetbot command from unauthorized user #{m.user.nick}"
      m.reply 'Permission denied. This command is only available to opers.'
      return
    end

    db_bot = Bots.first(authname: authname)

    if db_bot.nil?
      m.reply "Couldn't find bot with authname #{authname}"
      return
    end
    password = Bots.friendly_token

    db_bot.password = password
    db_bot.save

    info "Password was reset for #{authname}"

    m.user.notice "Password for #{authname}: #{password}"
    m.reply 'The new password was sent in private. ' \
            "Use /msg #{m.bot.nick} IDENTIFY <password> to login."
  end
end
