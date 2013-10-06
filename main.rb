load 'point.rb'
load 'point_manager.rb'
load 'tsp_solver.rb'


points = TSPSolver.exec(PointManager.new.import_256_points)

File.open("tsp.dat", 'w') { |file|
  points.each do |point|
    file.write(point.x.to_s + ' ' + point.y.to_s + "\n")
  end
}

def gnuplot(commands)
  IO.popen("gnuplot", "w") { |io| io.puts commands }
end

commands = %Q(
  set terminal svg
  set output "curves.svg"
  set xtics format " "
  set ytics format " "
  set title "TSP 512 points avec diviser pour regner - T=21.93"
  set style line 1 lc rgb '#0060ad' lt 1 lw 2
  set style line 2 lc rgb '#dd181f' pt 7 ps 1.5
  plot "tsp.dat" with lines ls 1 notitle
)
gnuplot(commands)