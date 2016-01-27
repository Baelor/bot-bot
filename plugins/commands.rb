# List of commands supported by bot-bot
class Commands
  include Cinch::Plugin

  match /c(?:ommands)?/

  def execute(m)
    commands = [
      '!delbot <authname> - Delete access',
      'IDENTIFY <password> - Login as a bot (in PRIVMSG)',
      '!listbots - Get a list of all registered bots',
      '!regbot <nick> - Register a new bot',
      '!resetbot <authname> - Reset password'
    ]
    m.reply 'Commands:'
    commands.each { |c| m.reply c }
  end
end
