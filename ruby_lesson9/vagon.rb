require_relative 'modules/module_vendor_name'

class Vagon
  include VendorName
  attr_reader :vagon_type

  def initialize(vagon_type)
    @type = vagon_type
  end
end
