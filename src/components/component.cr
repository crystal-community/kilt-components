module Kilt::Component
  macro included
    {% verbatim do %}
    macro finished
      {% for c in Kilt::Component.includers %}
        def {{c.constant("COMPONENT__NAME").id}}(*args)
          {{c}}.new(*args).render
        end
      {% end %}
    end
    {% end %}
  end
end
