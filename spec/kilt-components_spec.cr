require "./spec_helper"

Kilt::Component.import_components("spec/fixture1")

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

This is text
This is more text


There is no template with this component"
  end

  it "Correctly points to component in exceptions" do
    KiltComponentSpec::ExceptionComponent.new.render
    fail("Exception should have been thrown")
  rescue e : Exception
    e.backtrace[0].should eq "spec/fixture1/namespace/exception.cr:6:7 in 'raise_exc'"
  end

  it "Supports blocks in components" do
    KiltComponentSpec::TestingBlock.new.render.should eq "<This>is the top level text</This>
<This>is outer text</This>

  <This>is inner text</This>
<This>is more outer text</This>
37
<And>this is the final text</And>"
  end
end
