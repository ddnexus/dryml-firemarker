require 'pathname'
require 'rbconfig'

module DrymlFireMarker

  extend self

  VERSION = File.read(File.expand_path('../../VERSION', __FILE__)).strip

  WINDOZE = RbConfig::CONFIG['host_os'] =~ /mswin|msys|mingw32|windows/i

  def metadata_to_json(template_path, kind, name, line, *args)
    keys            = [ ] # we need to keep track of the key order for ruby 1.8.x unordered hashes
    metadata        = { }
    metadata[kind]  = name
    keys.push(kind)
    path            = Pathname.new(template_path).realpath.to_s
    writeable       = path.match(/^#{Regexp.quote(rails_root)}\//) &&
                      ( auto_path.blank? ||! path.match(/^#{Regexp.quote(auto_path)}\//) )
    path.gsub!(%r{/}, '\\\\\\\\') if WINDOZE # ridiculous escaping needed !!!
    unless args.empty?
      metadata['args'] = args.join(' | ')
      keys.push('args')
    end
    metadata['path'] = path + ':' + line.to_s + (writeable ? '+' : '')
    keys.push('path')
    "{#{ keys.map{|k| k.inspect + ':' + metadata[k].inspect}.join(',') }}"
  end

  private

  def auto_path
    @auto_path ||= Object.const_defined?(:Dryml) ?
        Dryml::DrymlGenerator.output_directory.to_s :
        Hobo::Dryml::DrymlGenerator::OUTPUT.to_s
  end

  def rails_root
    @rails_root ||= Object.const_defined?(:Rails) ? Rails.root.to_s : RAILS_ROOT
  end

end

