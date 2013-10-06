class TSPSolver

  def self.exec(point_manager)
    point  = point_manager.get_first_point
    points = Array.new

    points.push(point)
    last_point = point
    while point_manager.size != 0
      last_point = point_manager.closest_point(last_point)
      points.push(last_point)
    end

    points.push(point)

    points
  end

end