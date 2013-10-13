class TSPSolver

  # Résolution du problème du TSP
  # Cout : O(n + (n-1) + ... + 1) = O((n)(n+1)/2) = O(n^2)
  # @return [Array(Point)]
  # @param [PointManager] point_manager
  def self.exec_glouton(point_manager)
    # On crée un tableau qui contiendra les points et l'ordre dans
    # lequel les parcourir
    points      = Array.new

    # On récupère le premier point du Array
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
    last_point.distance_closest_point=last_point.square_distance(first_point)
    points.push(first_point)

    points
  end

  # @param [PointManager] point_manager
  # @return [Array(Point)]
  def self.exec_dtc(point_manager)
    # On récupère le tableau de points
    points = point_manager.to_a
    # On le trie selon la position des points par rapport à l'axe des abscisses
    origin = Point.new(0.5, 0.5)
    points.sort! { |a, b| a.square_distance(origin) <=> b.square_distance(origin) }

    # on la le truc récursif
    exec_dtc_intern(points, 0, point_manager.size-1)

    final_points = Array.new

    point = points[0]
    until point.next.nil?
      final_points.push(point)
      point = point.next
    end
    final_points.push(points[0])

  end

  private
  # @param [Array(Point)] points
  def self.exec_dtc_intern(points, first, last)
    #puts 'First : ' + first.to_s + ' -- LAST : ' + last.to_s

    # si il ne reste que 3 points, on les chaines
    if last-first == 2
      points[first].next_point   = points[first+1]
      points[first+1].next_point = points[first+2]
    # même chose, si il n'en reste que 2
    elsif last-first == 1
      points[first].next_point = points[first+1]
    else
      # l'arrondi supprime la partie flottante
      middle = (first + ((last-first) / 2)).to_i

      #puts 'First : ' + first.to_s + ' -- LAST : ' + last.to_s + ' -- MIDDLE : ' +middle.to_s

      # On execute la fonction sur les 2 sous parties du tableau
      exec_dtc_intern(points, first, middle)
      exec_dtc_intern(points, middle+1, last)

      # On chaine les 2 points non liés des sous tableaux
      points[middle].next_point = points[middle+1]
    end
  end

end