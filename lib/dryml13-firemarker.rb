require 'dryml/template'
require 'dryml-firemarker'

module Dryml

  include DrymlFireMarker::SharedOverrides

  class Template

    def wrap_source_with_metadata(content, kind, name, line, *args)
      return content if name.in?(NO_METADATA_TAGS)
      json = DrymlFireMarker.metadata_to_json(@template_path, kind, name, line, *args)
      uid = rand(10000000000)
      <<-source
        <% timestamp#{uid} = Time.now.to_f; safe_concat(%(<!--[dryml]#{json}-->)) %>
        #{content}
        <% safe_concat(%(<!--[/dryml]{"time":"\#{(Time.now.to_f - timestamp#{uid})*1000}ms"}-->)) %>
      source
    end

  end
end
