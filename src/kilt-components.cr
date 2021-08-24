require "kilt"

module Kilt::Component
  macro import_components(directory)
    {% begin %}
    {{ run("./components/compile_components", directory) }}
    # Insert { % debug % } here to see the full component tree code
    {% end %}
  end
end
