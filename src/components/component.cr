module Kilt::Component
  macro included
    {% verbatim do %}
    macro finished
      {% for c in Kilt::Component.includers %}
        def {{c.constant("COMPONENT__NAME").id}}(*args, **kwargs)
          {{c}}.new(*args, **kwargs).as(Kilt::Component)
        end
      {% end %}
    end
    {% end %}
  end
end
