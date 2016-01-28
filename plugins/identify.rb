require 'cinch'
require './lib/settings'
require './lib/db'
require './lib/models/bots'

# Login as a bot
class Identify
  include Cinch::Plugin

  set :prefix, /^/
  match /ID(?:ENTIFY)? (.*)?/i

  def execute(m, password)
    # only listen to IDENTIFY via PRIVMSG
    return if m.channel?

    unless m.user.authed?
      info "Login attempt by non-authenticated user #{m.user.nick}"
      m.reply 'You are not authenticated with NickServ.'
      return
    end

    db_bot = Bots.first(authname: m.user.authname)

    if db_bot.nil?
      info "Login attempt by unknown authname #{m.user.authname}"
      m.reply 'Your AuthName is not registered as a bot.'
      return
    end

    if db_bot.authenticate(password)
      db_bot.last_login = Time.zone.now
      db_bot.last_login_nick = m.user.nick
      db_bot.save
      info "Successful login by #{m.user.authname}"
      m.bot.irc.send("OS SVSOPER #{m.user.nick} #{settings.bot_oper_class}")
      m.reply 'You are now logged in as a bot.'
    else
      warn "Failed login attempt by #{m.user.authname}"
      m.reply 'Invalid password.'
    end
  end
end
