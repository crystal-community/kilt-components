module KiltComponentSpec
  class NoTemplate
    include Kilt::Component

    def render
      "There is no template with this component"
    end
  end
end
