# frozen_string_literal: true

module Unparser
  class Emitter
    # Emitter for pin nodes
    class Pin < self

      handle :pin

      children :target

    private

      # Perform dispatch
      #
      # @return [undefined]
      #
      # @api private
      #
      def dispatch
        write('^')
        visit(target)
      end
    end # Pin
  end # Emitter
end # Unparser
