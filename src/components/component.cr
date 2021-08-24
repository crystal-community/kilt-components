module Kilt::Component
  macro generate_render(component)
    def render
      Kilt.render({{component}})
    end
  end

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
