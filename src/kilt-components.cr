require "kilt"

module Kilt::Component
  macro import_components(directory)
    {% begin %}
    {{ run("./components/compile_components", directory) }}
    {% end %}
  end
end
