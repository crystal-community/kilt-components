module KiltComponentSpec
  class Section
    include Kilt::Component

    def initialize(@name : String, @description : String)
    end
  end
end
