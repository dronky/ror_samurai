require_relative 'vagon'

class CargoVagon < Vagon
  def initialize
    super(:cargo)
  end
end