class TSPSolver

  # Résolution du problème du TSP
  # Cout : O(n + (n-1) + ... + 1) = O((n)(n+1)/2) = O(n^2)
  #
  # @param [PointManager] point_manager
  # @return [Array<Point>]
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
    last_point.distance_closest_point=Math.sqrt(last_point.square_distance(first_point))
    points.push(first_point)

    points
  end

  # Résolution du problème du TSP par une méthode Divide To Conquer (DTC)
  # Le principe est de l'ensemble des points en 2 sous groupes selon leur positionnement
  # sur l'axe des abscisses, puis découper chaque sous groupe en fonction de la position
  # des points sur l'axe des ordonnées, et ainsi de suite, jusqu'à retomber sur le case
  # de base, ou on relie entre eux 2 ou 3 points
  #
  # @param [PointManager] point_manager
  # @return [Array<Point>]
  def self.exec_dtc(point_manager)
    # On récupère le tableau de points
    points      = point_manager.to_a

    # On lance la résolution récursive
    final_deque = exec_dtc_intern(points, true)

    # On transforme notre deque de points en un tableau
    # afin de le ploter facilement dans gnuplot
    final_points = Array.new
    point        = final_deque[0]
    until point.next.nil?
      final_points.push(point)
      point = point.next
    end
    point.next_point(final_deque[0])
    final_points.push(final_deque[0])

    final_points
  end

  private
  # On résoud un problème / sous problème composé de 2 paramètres
  # la liste des points à relier entre eux et l'axe selon lequel
  # découper ces points
  #
  # Cout : Tri des points : O(nlogn) + 2T(n/2) -> O(logn * nlogn)
  #
  # /!\ Le résultat est une Double - Ended queue de points
  # modélisée par un tableau à 2 éléments :
  #     - le premier est un pointeur vers le premier point
  #     - le second est un pointeur vers le dernier point
  #
  # @param [Array<Point>] points
  # @param [Boolean] horizontal
  # @return [Array(Point, Point)]
  def self.exec_dtc_intern(points, horizontal)

    # Cas de base "1"
    # Lorsqu'il ne nous reste que 3 points, on les chaine "arbitrairement" entre eux
    if points.length == 3
      points[0].next_point(points[1])
      points[1].next_point(points[2])
      [points[0], points[2]]

      # Cas de base "2"
      # même chose, si il n'en reste que 2
    elsif points.length == 2
      #puts 'Fin'
      points[0].next_point(points[1])
      [points[0], points[1]]

      # Cas récursif
    else

      # En fonction du boolean, on trie les points selon un des deux axes
      if horizontal
        points.sort! { |a, b| b.x <=> a.x }
      else
        points.sort! { |a, b| b.y <=> a.y }
      end

      # On calcul la longueur des sous parties
      half         = points.length / 2

      # On s'appelle récursivement sur la première et la seconde partie du sous tableau
      # et on inverse l'axe selon lequel on découpera les sous zones
      first_deque  = exec_dtc_intern(points.slice(0, half), !horizontal)
      second_deque = exec_dtc_intern(points.slice(half, points.length), !horizontal)

      # Nous avons donc 2 deques, on regarde comment si il vaut mieux positionner la
      # première avant ou après la seconde
      # Et on renvoit la deque nouvellement crée
      if first_deque[1].square_distance(second_deque[0]) < first_deque[0].square_distance(second_deque[1])
        first_deque[1].next_point(second_deque[0])
        [first_deque[0], second_deque[1]]
      else
        second_deque[1].next_point(first_deque[0])
        [second_deque[0], first_deque[1]]
      end

    end
  end
end