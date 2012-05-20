module Spree
  class PossiblePage
    def self.matches?(request)
      return false if request.fullpath =~ /(^\/\/+(admin|account|cart|checkout|content|login|pg\/|orders|products|s\/|session|signup|shipments|states|tax_categories|user)+)/
      !Page.active.find_by_path(request.fullpath).nil?
    end
  end
end