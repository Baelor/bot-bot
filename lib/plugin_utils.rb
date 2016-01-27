require './lib/models/bots'

# Shared plugin util methods
module PluginUtils
  def authorized?(user)
    user.oper? && Bots.where(authname: user.authname).count.zero?
  end
end
