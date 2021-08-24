require "./spec_helper"

Kilt::Component.import_components("spec/components")

describe Kilt::Component do
  it "renders" do
    KiltComponentSpec::Root.new("My Project", "Super cool, it is").render.should eq "# My Project
--------------

Super cool, it is

<h3>Description</h3>
details

<ul>
  <li>item1</li>
  <li>item2</li>
  <li>???</li>
  <li>Profit</li>
</ul>
"
  end
end
