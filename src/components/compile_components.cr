if File.exists?("#{Dir.current}/lib/kilt-compnonents/src/components/component.cr")
  # Pull in the component file if we're running as a shard
  puts File.read("#{Dir.current}/lib/kilt-compnonents/src/components/component.cr")
elsif File.exists?("#{Dir.current}/src/components/component.cr")
  # or directly from this project (probably running tests)
  puts File.read("#{Dir.current}/src/components/component.cr")
end

expanded = Path[ARGV[0]].expand.to_s

Dir.children(expanded).each do |namespace|
  Dir.children("#{expanded}/#{namespace}").each do |component|
    file = File.read("#{expanded}/#{namespace}/#{component}/#{component}.cr")
    candidates = Dir.children("#{expanded}/#{namespace}/#{component}") - ["#{component}.cr"]
    # TODO: need to actually inspect candidates and find one that is supported by Kilt
    template = candidates[0]
    lines = file.split("\n")
    lines.each_with_index do |line, i|
      if line.match(/include.*?Kilt::Component/)
        leading_whitespace = line.split(/\S/, 2)[0]
        lines.insert(i + 1, "#{leading_whitespace}generate_render(\"#{expanded}/#{namespace}/#{component}/#{template}\")")
        lines.insert(i + 2, "#{leading_whitespace}COMPONENT__NAME = \"#{namespace}_#{component}\"")
        break
      end
    end
    puts lines.join("\n")
  end
end
