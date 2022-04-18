module KiltComponentSpec
  class ComponentList
    include Kilt::Component

    getter arr

    def initialize(@arr : Array(Kilt::Component))
    end
  end
end
