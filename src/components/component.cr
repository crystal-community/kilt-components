module Kilt::Component
  macro has_slot
    @_slot : Proc(String)? = nil

    def render_slot?
      return "" unless slot = @_slot
      slot.call
    end

    def render_slot
      raise "Slot not filled" unless slot = @_slot
      slot.call
    end

    def initialize(*args, **props, &block : -> String)
      initialize(*args, **props)
      @_slot = block
    end
  end

  macro included
    {% verbatim do %}
    macro finished
      {% for c in Kilt::Component.includers %}
        def {{c.constant("COMPONENT__NAME").id}}(*args, **kwargs)
          {{c}}.new(*args, **kwargs).as(Kilt::Component)
        end

        def render_{{c.constant("COMPONENT__NAME").id}}(*args, **kwargs)
          {{c}}.new(*args, **kwargs).as(Kilt::Component).render
        end

        def {{c.constant("COMPONENT__NAME").id}}(*args, **kwargs, &block : -> String)
          {{c}}.new(*args, **kwargs, &block).as(Kilt::Component)
        end

        def render_{{c.constant("COMPONENT__NAME").id}}(*args, **kwargs, &block : -> String)
          {{c}}.new(*args, **kwargs, &block).as(Kilt::Component).render
        end
      {% end %}
      {% debug if flag?(:DEBUG) %}
    end
    {% end %}
  end
end
