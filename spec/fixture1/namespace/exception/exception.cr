module KiltComponentSpec
  class ExceptionComponent
    include Kilt::Component

    def raise_exc
      raise Exception.new("This is an error")
    end
  end
end
