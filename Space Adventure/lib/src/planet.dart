// A class of planets that stores its name and a description of the planet
class Planet{
  final String name;
  final String description;

  // Planet name constructor
  Planet({this.name, this.description});

  // Null planet name constructor
  Planet.nullPlanet() : name = 'Null', description = 'Null';
}
