version = File.read(File.expand_path('../VERSION', __FILE__)).strip
require 'date'

Gem::Specification.new do |s|
  s.name                      = 'dryml-firemarker'
  s.summary                   = 'Adds DRYML markers viewable with FireMarker'
  s.description               = 'Dryml FireMarker annotates the output of Hobo and Rails apps that use the DRYML templating system.'
  s.authors                   = ["Domizio Demichelis"]
  s.email                     = 'dd.nexus@gmail.com'
  s.homepage                  = "http://github.com/ddnexus/dryml-firemarker"
  s.extra_rdoc_files          = ["README.md"]
  s.require_paths             = ["lib"]
  s.files                     = `git ls-files -z`.split("\0")
  s.version                   = version
  s.date                      = Date.today.to_s
  s.required_rubygems_version = ">= 1.3.6"
  s.rdoc_options              = ["--charset=UTF-8"]
end

