module KiltComponentSpec
  class Blocked
    include Kilt::Component

    @child : Proc(String)

    def initialize(&block : -> String)
      @child = block
    end
  end
end
