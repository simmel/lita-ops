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

    end

    Lita.register_handler(Ops)
  end
end
