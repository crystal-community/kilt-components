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
        macro {{c.constant("COMPONENT__NAME").id}}(*args, **kwargs, &block)
          \{% if block %}
            \{% if args.size > 0 && kwargs.size > 0 %}
            {{c}}.new(\{{*args}}, \{{**kwargs}}) { \{{yield}} }.as(Kilt::Component)
            \{% elsif args.size > 0 %}
            {{c}}.new(\{{*args}}) { \{{yield}} }.as(Kilt::Component)
            \{% elsif kwargs.size > 0 %}
            {{c}}.new(\{{**kwargs}}) { \{{yield}} }.as(Kilt::Component)
            \{% else %}
            {{c}}.new \{{yield}}.as(Kilt::Component)
            \{% end %}
          \{% else %}
            \{% if args.size > 0 && kwargs.size > 0 %}
            {{c}}.new(\{{*args}}, \{{**kwargs}}).as(Kilt::Component)
            \{% elsif args.size > 0 %}
            {{c}}.new(\{{*args}}).as(Kilt::Component)
            \{% elsif kwargs.size > 0 %}
            {{c}}.new(\{{**kwargs}}).as(Kilt::Component)
            \{% else %}
            {{c}}.new.as(Kilt::Component)
            \{% end %}
          \{% end %}
        end

        macro render_{{c.constant("COMPONENT__NAME").id}}(*args, **kwargs, &block)
          \{% if block %}
            \{% if args.size > 0 && kwargs.size > 0 %}
            {{c}}.new(\{{*args}}, \{{**kwargs}}) { \{{yield}} }.as(Kilt::Component).render
            \{% elsif args.size > 0 %}
            {{c}}.new(\{{*args}}) { \{{yield}} }.as(Kilt::Component).render
            \{% elsif kwargs.size > 0 %}
            {{c}}.new(\{{**kwargs}}) { \{{yield}} }.as(Kilt::Component).render
            \{% else %}
            {{c}}.new { \{{yield}} }.as(Kilt::Component).render
            \{% end %}
          \{% else %}
            \{% if args.size > 0 && kwargs.size > 0 %}
            {{c}}.new(\{{*args}}, \{{**kwargs}}).as(Kilt::Component).render
            \{% elsif args.size > 0 %}
            {{c}}.new(\{{*args}}).as(Kilt::Component).render
            \{% elsif kwargs.size > 0 %}
            {{c}}.new(\{{**kwargs}}).as(Kilt::Component).render
            \{% else %}
            {{c}}.new.as(Kilt::Component).render
            \{% end %}
          \{% end %}
        end
      {% end %}
      {% debug if flag?(:DEBUG) %}
    end
    {% end %}
  end
end
