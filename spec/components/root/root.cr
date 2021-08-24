module KiltComponentSpec
  class Root
    include Kilt::Component

    def initialize(@name : String, @summary : String)
    end

    def items
      [
        "item1",
        "item2",
        "???",
        "Profit",
      ]
    end
  end
end
