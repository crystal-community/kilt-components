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
      leading_whitespace = line.split(/\S/, 2)[0]
      lines.insert(i + 1, "#{leading_whitespace}generate_render(\"#{expanded}/#{component}/#{template}\")")
      # lines.insert(i + 2, "def self.__component_name; \"#{component}\"; end")
      lines.insert(i + 2, "#{leading_whitespace}COMPONENT__NAME = \"#{component}\"")
      break
    end
  end
  puts lines.join("\n")
end
