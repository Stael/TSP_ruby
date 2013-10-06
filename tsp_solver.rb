class TSPSolver

  def self.exec(point_manager)
    # On crée un tableau qui contiendra les points et l'ordre dans
    # lequel les parcourir
    points      = Array.new

    # On récupère le premier point du Set
    first_point = point_manager.get_first_point

    # On ajoute le premier point à notre tableau
    points.push(first_point)

    # Le premier point devient le dernier
    last_point = first_point

    # Tant qu'il reste des points à traiter
    while point_manager.size != 0
      # On cherche le point le plus proche du dernier point
      last_point = point_manager.closest_point(last_point)
      # On l'ajoute à notre tableau
      points.push(last_point)
    end

    # On revient au point de départ
    last_point.distance_closest_point=last_point.distance(first_point)
    points.push(first_point)

    points
  end

end