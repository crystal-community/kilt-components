# Kilt Components

The goal of this library is to support a modular component library of ever nested templated components, to generate a static page that can be built from building block components.

This library uses [Kilt](https://github.com/jeromegn/kilt) as the underlying templating engine, and so Kilt supported templating languages should also be supported by this library. However, only ECR, Slang, Liquid, and Water have been tested so far.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     kilt-components:
       github: vici37/kilt-components
   ```

2. Run `shards install`

## Usage

Start with a directory of components, where each subdirectory is considered one component. Each component directory contains two files, one being the crystal controller and the other being a template for the view of that component. Using the spec component library as an example:

```
spec/fixture1/namespace
├── list
│ ├── list.cr
│ └── list.water
├── root
│ ├── root.cr
│ └── root.ecr
├── section
│ ├── section.cr
│ └── section.slang
├── text
|   ├── text.cr
|   └── text.liquid
└── component_list
    ├── component_list.cr
    └── component_list.liquid

```

```crystal
require "kilt-components"

# This macro will import all components at this location.
# Folder path passed in is the relative location to the root of all components
Kilt::Component.import_components("spec/fixture1")

rendered = KiltComponentSpec::Root.new("My Project", "Summary of project").render
```

The initial `root.ecr` looks like:
```crystal
# <%= @name %>
--------------

<%= @summary %>

<%= namespace_section("Description", "details").render %>

<%= namespace_list(items).render %>

<%= namespace_component_list([namespace_text("This is text"), namespace_text("This is more text")]).render %>
```

And the `rendered` string is now:
```
# My Project
--------------

Summary of project

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
```

Every component is accessible to every other component through injected methods that wrap
the constructor and a newly added `render` method. I.e. for component `root` above to
access the `list` component, it would use the method `namespace_list(["item1", "item2", "etc"])`,
which will return an instance of the component as if constructed through its `new` method with whatever parameters
are passed in. If a direct render is desired, you can instead call `render_namespace_list(...)`.

## Blocks

New convenience methods were added so that blocks can be forwarded to the constructor of components
that wish to wrap sub content on the fly:

```crystal
# namespace/blocked_component.cr
class Blocked
  include Kilt::Component

  @child : Proc(String)

  def initialize(&block : -> String)
    @child = block
  end
end

# namespace/blocked_component.slang
div.my-class
  == @child.call

# namespace/some_other_component.slang
== render_namespace_blocked_component do
  p This is a paragraph rendered in a div with css "my-class"
```

Renders into:

```html
<div class="my-class">
  <p>This is a paragraph rendered in a div with css "my-class"</p>
</div>
```

## Features

* Supports any templating language supported by [kilt](https://github.com/jeromegn/kilt)
* Stitches together component templates to allow component re-use
* Exceptions thrown by a component correctly point to the component file
* All components have a namespace
* Convenience methods to construct components with their arguments, supports blocks

## Contributors

- [Troy Sornson](https://github.com/your-github-user) - creator and maintainer
