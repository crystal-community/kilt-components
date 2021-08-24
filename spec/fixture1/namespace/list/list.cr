module KiltComponentSpec
  class List
    include Kilt::Component

    def initialize(@items : Array(String))
    end
  end
end
