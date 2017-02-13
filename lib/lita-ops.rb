require "lita"
require "monkeypatches"

module Lita
  module Handlers
    class Ops < Handler

      config :should_be_oped, type: Hash, required: true

      on(:connected) do |payload|
        if robot.send(:adapter).class != Lita::Adapters::IRC
          log.fatal "Only the IRC adapter is supported."
          exit
        end
      end

      on :user_joined_room, :op

      def should_be_oped?(channel, nick)
        if config.should_be_oped.include?(channel)
          config.should_be_oped[channel].each do |u|
            if Cinch::Mask.new(u) =~ nick.mask
              log.debug "#{u} matched!"
              return true
            end
          end
        end
        return false
      end

      def op(payload)
        cinch = robot.send(:adapter).cinch
        nick = cinch.user_list.find_ensured(payload[:user].name)
        channel = payload[:room].name

        payload[:room].op(robot, nick) if should_be_oped?(channel, nick)
      end

    end

    Lita.register_handler(Ops)
  end
end
