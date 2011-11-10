module DrymlRootModule

  include DrymlFireMarker::SharedOverrides

  class TemplateEnvironment
    undef_method :part_contexts_javascripts
  end

  if DRYML_METAINFO
    class Template
      def wrap_source_with_metadata(content, kind, name, line, *args)
        return content if name.in?(NO_METADATA_TAGS)
        json = DrymlFireMarker.metadata_to_json(@template_path, kind, name, line, *args)
        "<!--[dryml]#{json}-->" + content + "<!--[/dryml]-->"
      end
    end
  end

  class Taglib
    class << self
      def taglib_filename_with_firemarker(options)
        if options[:plugin] == "dryml-firemarker"
          File.expand_path('../dryml-firemarker.dryml', __FILE__)
        else
          taglib_filename_without_firemarker(options)
        end
      end
      alias_method_chain :taglib_filename, :firemarker
    end
  end

end
