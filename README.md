# Description

Ce projet a été réalisé par Théo Bessel et Benjamin Soyer, deux étudiants en première année à l'N7, dans le département Sciences du Numérique.


# Compilation

Pour compiler le projet, veuiller exécuter le script `./build.sh`.

En ajoutant l'argument `-run` à ce script, ce dernier exécute directement le code compilé.

En ajoputant `-test` à ce script, ce dernier exécute les modules de test des différents paquets.

# Architecture du projet

Pour chaque paquet, on trouvera un module de test sous la forme `test_<nom_paquet>.adb`.

## 1. Paquet `Graph`

Ce paquet donne une implémentation des graphes orientés utilisés pour le page ranking. La matrice/liste d'adjacence est un type générique qui permet d'implémenter les différents algorithmes en matrice pleine/creuse.

## 2. Paquet `Matrix`

Ce paquet donne une implémentation des matrices utilisées pour le page ranking. Il est basé sur l'utilisation du type primitif `Array` du langage Ada. On utilise un seul `Array` afin d'assurer la contigüité en mémoire des données qui y sont stockées.

## 3. Paquet `IOStream`

Ce paquet fournit les différentes fonctions permettant de gérer les paramètres d'entrée du programme ainsi que l'affichage des différentes sorties.

## 4. Paquet `Algorithm`

Ce paquet donne une implémentation de l'algorithme de page ranking basé sur les différents paquets détaillés ci-dessus.

# Benckmark du projet

Vous trouverez ci-dessous l'évaluation des performance de ce projet.