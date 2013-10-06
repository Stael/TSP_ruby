class Point

  attr_accessor :x, :y, :distance_closest_point

  def initialize(x, y)
    @x = x
    @y = y
    @distance_closest_point = 0
  end

  # Calcul de la distance entre 2 points
  # @param [Point] point
  def distance(point)
    Math.sqrt((@x - point.x)**2 + (@y - point.y)**2)
  end

  # Affichage d'un point
  # @return [String]
  def to_s
    'x : ' + @x.to_s + ' - y : ' + @y.to_s
  end

end