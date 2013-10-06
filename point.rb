class Point

  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  # @param [Point] point
  def distance(point)
    Math.sqrt((@x - point.x)**2 + (@y - point.y)**2)
  end

  # @return [String]
  def to_s
    'x : ' + @x.to_s + ' - y : ' + @y.to_s
  end

end