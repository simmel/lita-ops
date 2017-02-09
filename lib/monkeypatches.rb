module ::Lita
  class Room

    def op(robot, nick)
      cinch = robot.send(:adapter).cinch
      channel = cinch.channel_list.find_ensured(self.name)
      Lita.logger.debug "Oping #{nick} in #{self.name}"
      channel.op(nick)
    end

  end
end
