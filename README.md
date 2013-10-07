TSP
======

Installation des gems nécessaires
------------
    * via bundler :
        $ gem install bundler
        $ bundle install
    * "à la main" :
        $ gem install json
        $ gem install gnuplot

Fonctionnement
------------
    * $ ruby main.rb
    * Le résultat est exporté en 2 fichiers :
        - tsp.dat qui contient les coordonnées des points dans l'ordre dans lequel il faut les parcourir
        - curves.svg qui est une conversion en graphique du fichier tsp.dat

Choix nombre de points
------------
    Dans le fichier main.rb
        * remplacer : import_512_points par au choix :
            import_16_points
            import_32_points
            import_64_points
            import_128_points
            import_256_points
            import_1024_points
            import_4096_points
            generate(X) ou X est un entier