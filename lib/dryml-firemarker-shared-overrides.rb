module DrymlFireMarker
  module SharedOverrides

    def compile_renderer_class_with_firemarker(*args)
      taglibs = args.pop
      taglibs << {:plugin => 'dryml-firemarker'}
      args.push(taglibs)
      compile_renderer_class_without_firemarker(*args)
    end

    def included(base)
      base.class_eval do
        alias_method_chain :compile_renderer_class, :firemarker
        private :compile_renderer_class_with_firemarker, :compile_renderer_class_without_firemarker
      end
    end

  end
end
