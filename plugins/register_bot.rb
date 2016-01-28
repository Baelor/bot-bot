require 'cinch'
require './lib/settings'
require './lib/db'
require './lib/plugin_utils'
require './lib/models/bots'

# Register a new bot
class RegisterBot
  include Cinch::Plugin
  include PluginUtils

  match /regbot (.*)?/i

  def execute(m, nick)
    nick.strip!
    unless authorized?(m.user)
      warn "Received !regbot command from unauthorized user #{m.user.nick}"
      m.reply 'Permission denied. This command is only available to opers.'
      return
    end

    regbot = m.bot.user_list.find_ensured(nick)

    unless regbot.online?
      m.reply "#{nick} is not connected to this server."
      return
    end

    unless regbot.authed?
      m.reply "#{nick} is not authenticated."
      return
    end

    password = Bots.friendly_token

    begin
      Bots.create(
        authname: regbot.authname,
        password: password,
        added_by: m.user.authname,
        added_at: Time.zone.now
      )
    rescue Sequel::UniqueConstraintViolation
      m.reply "#{nick} (Auth: #{regbot.authname}) is already registered."
      m.reply "Use !resetbot #{regbot.authname} to reset the password."
      return
    end

    info "Registered new bot #{nick} (Auth: #{regbot.authname})"

    m.user.notice "Password for #{nick}: #{password}"

    m.reply "#{nick} (Auth: #{regbot.authname}) is now registered as a bot."
    m.reply 'The password was sent in private. ' \
            "Use /msg #{m.bot.nick} IDENTIFY <password> to login."
  end
end
