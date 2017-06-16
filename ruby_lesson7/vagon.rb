require_relative 'module_vendor_name'

class Vagon
  include VendorName

  attr_reader :type

  def initialize(type)
    @type = type
  end
end
