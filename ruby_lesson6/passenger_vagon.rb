require_relative 'vagon'

class PassengerVagon < Vagon
  def initialize
    super(:pass)
  end
end