module Kilt::Component
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
