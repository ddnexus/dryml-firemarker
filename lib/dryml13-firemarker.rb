require 'dryml/template'
require 'dryml-firemarker'

module Dryml
  class Template

    def wrap_source_with_metadata(content, kind, name, line, *args)
      return content if name.in?(NO_METADATA_TAGS)
      json = DrymlFireMarker.metadata_to_json(@template_path, kind, name, line, *args)
      "<% safe_concat(%(<!--[dryml]#{json}-->)) %>" + content + "<% safe_concat(%(<!--[/dryml]-->)) %>"
    end

  end
end
