import 'dart:math';

import 'planet.dart';


class PlanetarySystem {
  final Random _random = Random();
  final String name;
  final List<Planet> planets;

  PlanetarySystem({this.name='Unnamed System', this.planets=const[]});

  // Getter to return number of planets in list
  int get numberOfPlanets => planets.length;

 // Getter to return bool if list is empty or not
  bool get hasPlanets => planets.isNotEmpty;

  // Determines a random planet object to return
  Planet randomPlanet(){
    // Guard statement if there are 0 planets in the 'planets' list
    if (!hasPlanets) return Planet.nullPlanet();
    return planets[_random.nextInt(planets.length)];
  }

  // Returns planet with matching name or returns Null planet object 
  // if there are no matches
  Planet planetWithName(String name){
    return planets.firstWhere(
      (planet) => planet.name == name,
      orElse: () => Planet.nullPlanet());
  }

}