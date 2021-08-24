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
        {% name = c.name.split("::")[-1].gsub(/[A-Z]/, "_\\0").gsub(/^_/, "").downcase.id %}
        def {{name}}(*args)
          {{c}}.new(*args).render
        end
      {% end %}
    end
    {% end %}
  end
end
