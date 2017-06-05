require_relative 'Vagon'

class CargoVagon < Vagon
  def initialize
    super(:cargo)
  end
end