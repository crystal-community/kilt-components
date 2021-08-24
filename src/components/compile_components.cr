if File.exists?("#{Dir.current}/lib/kilt-compnonents/src/components/component.cr")
  # Pull in the component file if we're running as a shard
  puts File.read("#{Dir.current}/lib/kilt-compnonents/src/components/component.cr")
elsif File.exists?("#{Dir.current}/src/components/component.cr")
  # or directly from this project (probably running tests)
  puts File.read("#{Dir.current}/src/components/component.cr")
end

expanded = Path[ARGV[0]].expand.to_s

Dir.children(expanded).each do |component|
  file = File.read("#{expanded}/#{component}/#{component}.cr")
  candidates = Dir.children("#{expanded}/#{component}") - ["#{component}.cr"]
  template = candidates[0]
  lines = file.split("\n")
  lines.each_with_index do |line, i|
    if line.includes?("include Kilt::Component")
      lines.insert(i + 1, "#{line.split(/\S/, 2)[0]}generate_render(\"#{expanded}/#{component}/#{template}\")")
      break
    end
  end
  puts lines.join("\n")
end
