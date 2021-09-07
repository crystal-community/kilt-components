require "kilt"
require "./components/component"

module Kilt::Component
  macro generate_render(component)
    def render
      Kilt.render({{component}})
    end
  end

  macro import_components(directory)
    {% begin %}
    {{ run("./components/compile_components", directory) }}
    # Insert { % debug % } here to see the full component tree code
    {% end %}
  end
end
