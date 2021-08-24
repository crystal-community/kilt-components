module KiltComponentSpec
  class Text
    include Kilt::Component

    def initialize(@text : String)
    end
  end
end
