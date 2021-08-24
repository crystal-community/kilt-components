module KiltComponentSpec
  class Root
    include Kilt::Component
    @name = "My Project"
    @summary = "Super cool, it is"

    def items
      [
        "item1",
        "item2",
        "???",
        "Profit"
      ]
    end
  end
end
