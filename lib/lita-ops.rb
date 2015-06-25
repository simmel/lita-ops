require "lita"

module Lita
  module Handlers
    class Ops < Handler

      on(:connected) do |payload|
        if robot.send(:adapter).class != Lita::Adapters::IRC
          log.fatal "Only the IRC adapter is supported."
          exit
        end
      end

      on :room_join, :op

      def op(payload)
        target = Source.new(room: payload[:room])
        nick = payload[:nick]
        channel = Cinch::Channel.new(target.room, robot.send(:adapter).cinch)
        Lita.logger.debug("Oping nick #{nick} in channel #{target.room}")
        channel.op(nick)
      end

    end

    Lita.register_handler(Ops)
  end
end
