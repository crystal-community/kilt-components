module KiltComponentSpec
  class Blocked
    include Kilt::Component

    has_slot

    def initialize(my_int : Int32)
      @my_int = my_int
    end
  end
end
