# frozen_string_literal: true

module Unparser
  class Emitter

    # Emitter for begin nodes
    class Begin < self
      children :body

    private

      # Emit inner nodes
      #
      # @return [undefined]
      #
      # @api private
      #
      def emit_inner
        children.each_with_index do |child, index|
          visit_plain(child)
          write(NL) if index < children.length - 1
        end
      end

      # Emitter for implicit begins
      class Implicit < self
        include Terminated

        handle :begin

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        #
        def dispatch
          return if children.eql?([nil])

          conditional_parentheses(true) do
            emit_inner
          end
        end

      end # Implicit

      # Emitter for explicit begins
      class Explicit < self
        include Terminated

        handle :kwbegin

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        #
        def dispatch
          write(K_BEGIN)
          emit_body
          k_end
        end

        # Emit body
        #
        # @return [undefined]
        #
        # @api private
        #
        def emit_body
          if body.nil?
            nl
          elsif NOINDENT.include?(body.type)
            emit_inner
          else
            indented { emit_inner }
          end
        end

      end # Explicit

    end # Begin
  end # Emitter
end # Unparser
