import 'dart:convert';
import 'dart:io';
import 'package:dart_space_adventure/dart_space_adventure.dart';



void main(List<String> arguments) async {
  // Get data from JSON file specified in input argument command line
  var newFile = File(arguments[0]);
  var contents = await newFile.readAsString();  
  var planetarySystemData = json.decode(contents);

  // Save decoded JSON data as system name and planet data separately
  final systemName = planetarySystemData['name'];
  final planetData =  planetarySystemData['planets'];
  
  // Convert planet data into Planet class members
  final listP = listPlanets(planetData);

  // Call start() function in space_adventure.dart to run program
  SpaceAdventure(
    planetarySystem: PlanetarySystem(
      name: systemName, 
      planets: listP
      )
    ).start();
}

// Creates a Planet object for each one listed in JSON file and returns
// a list of Planet objects
List<Planet> listPlanets(planetData){
  var planets = List<Planet>();
  planetData.forEach( (entry) {
    var planet = Planet(name: entry['name'], description: entry['description']);
    planets.add(planet);
  });
  return planets;
}

