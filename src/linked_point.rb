class LinkedPoint < Point
  attr_accessor :next

  def next_point(point)
    self.next=point
    self.distance_closest_point=Math.sqrt(self.square_distance(point))
  end
end