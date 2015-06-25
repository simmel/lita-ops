module ::Lita
  module Adapters
    class IRC < Adapter
      class CinchPlugin

        listen_to :channel, method: :on_room_message
        listen_to :join, method: :on_room_join

        def on_room_message(m)
          unless m.user.nick == robot.send(:adapter).cinch.nick
            robot.trigger(:room_message,
                          room: m.channel.name,
                          message: m.message,
                          nick: m.user.nick,
                         )
          end
        end

        def on_room_join(m)
          unless m.user.nick == robot.send(:adapter).cinch.nick
            robot.trigger(:room_join,
                          room: m.channel.name,
                          nick: m.user.nick,
                         )
          end
        end

      end
    end
  end
end
