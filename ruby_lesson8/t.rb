module Testmodule
  def testvar
    @testvar ||=0
  end
  def addone
    @testvar ||=0
    @testvar+=1
  end
end
class Testclass
  include Testmodule
end
a = Testclass.new
a.addone
puts a.testvar