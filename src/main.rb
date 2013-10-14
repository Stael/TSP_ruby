load 'point.rb'
load 'linked_point.rb'
load 'point_manager.rb'
load 'tsp_solver.rb'

# On mémorise l'heure de début du programme
beginning      = Time.now

# On résoud le problème
nb_points      = 512
points         = TSPSolver.exec_dtc(PointManager.new.import_4096_points)

# On calcule la distance total
total_distance = 0.0
points.each do |point|
  total_distance = total_distance + point.distance_closest_point
end

# On sauvegarde les points dans un fichier
File.open("../out/tsp.dat", 'w') { |file|
  points.each do |point|
    file.write(point.x.to_s + ' ' + point.y.to_s + "\n")
  end
}

# Liste des commandes gnuplot pour tracer le résultat
commands = '
  set terminal svg
  set output "../out/curves.svg"
  set xtics format " "
  set ytics format " "
  set title "TSP ' + nb_points.to_s + ' points avec diviser pour regner - T=' + total_distance.round(2).to_s + '"
  set style line 1 lc rgb \'#0060ad\' lt 1 lw 2
  set style line 2 lc rgb \'#dd181f\' pt 7 ps 1.5
  plot "../out/tsp.dat" with lines ls 1 notitle
'

# On trace le résultat
IO.popen("gnuplot", "w") { |io| io.puts commands }

# On affiche le temps total d'execution
puts "Time elapsed #{Time.now - beginning} seconds"