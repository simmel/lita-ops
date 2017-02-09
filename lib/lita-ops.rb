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

      def op(payload)
        cinch = robot.send(:adapter).cinch
        nick = cinch.user_list.find_ensured(payload[:user].name)
        channel = payload[:room].name

        if config.should_be_oped.include?(channel)
          config.should_be_oped[channel].each do |u|
            if nick.mask.eql? Cinch::Mask.new(u)
              log.debug "#{u} matched!"
              payload[:room].op(robot, nick)
            end
          end
        end
      end

    end

    Lita.register_handler(Ops)
  end
end
