module Spree
  class PossiblePage

    def self.image_root_path
      Spree::Image.attachment_definitions[:attachment][:url].split('/').take_while {|c| !(c =~ /^:/) }.join('/')
    end

    def self.matches?(request)
      return false if request.fullpath.start_with?(image_root_path, '/assets')
      return false if request.fullpath =~ /(^\/+(admin|account|cart|checkout|content|login|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user)+)/
      !Page.active.find_by_path(request.fullpath).nil?
    end
  end
end