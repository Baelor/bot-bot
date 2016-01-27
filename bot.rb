require 'cinch'
require 'cinch/plugins/identify'
require 'sequel'
require './lib/settings'
require './plugins/commands'
require './plugins/delete_bot'
require './plugins/identify'
require './plugins/list_bots'
require './plugins/register_bot'
require './plugins/reset_bot'

bot = Cinch::Bot.new do
  configure do |c|
    c.server                                    = settings.server.host
    c.port                                      = settings.server.port
    c.nick                                      = settings.nick
    c.realname                                  = settings.realname
    c.user                                      = settings.user

    c.plugins.plugins = [Cinch::Plugins::Identify, Commands, DeleteBot,
                         Identify, ListBots, RegisterBot, ResetBot]

    c.plugins.options[Cinch::Plugins::Identify] = {
      username: settings.nickserv.username,
      password: settings.nickserv.password,
      type: :nickserv
    }
  end

  on :identified do
    bot.oper(settings.oper.password, settings.oper.username)
    settings.channels.each do |c|
      bot.join(c)
    end
  end
end

bot.loggers.level = settings.log_level
bot.start
