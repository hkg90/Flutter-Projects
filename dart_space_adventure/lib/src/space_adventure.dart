import 'dart:io';

import 'planet.dart';
import 'planetary_system.dart';

// Class for space adventure
class SpaceAdventure{

  final PlanetarySystem planetarySystem;

  SpaceAdventure({this.planetarySystem});

  void start(){
    // Print greeting
    printGreeting();
    // Get user name
    printIntroduction(promptAnswer('What is your name?'));
    print("Let's go on an adventure!\n");
    // Guard statement that relays message to use if there are no 
    // planets to travel to
    if (planetarySystem.hasPlanets){
      // Print message per travel specification
      travel(
        travelChoice(
          'Shall I randomly choose a planet for you to visit? (Y/N)')
        );
    }
    else {
      print('Oh no! There are no planets to explore.');
    }
  }


  // Prints greeting to user 
  void printGreeting(){
  print(
      'Welcome to the ${planetarySystem.name}!\n'
      'There are ${planetarySystem.numberOfPlanets} planets to explore.\n');
  }

  // Prints prompts to terminal
  String promptAnswer(String prompt){
    print(prompt);
    return stdin.readLineSync();
  }
  

  // Displays intro message to user
  void printIntroduction(String name){
    print(
        'Nice to mee you, $name. My name is Eliza, I\'m an old friend of Alexa.\n');
  }

  // Determines boolean value to return per user's response to Y/N entry request
  bool travelChoice(String prompt){
    String answer;
    while (answer != 'Y' && answer !='N'){
      answer = promptAnswer(prompt);
      if (answer == 'Y'){
          // Print travel message for random planet name
          return true;
        } else if (answer == 'N') {
          // Print travel message for specified planet name
          return false;
        } 
        // Loop until Y or N is received. Print error message to user otherwise
        else {
          print("Sorry I didn\'t get that.\n");
        }
      }
    return false; // Added this return statement to appease formater
  }

  // Determines planet name and description as needed
  void travel(bool chosenDestination){
    Planet planet;
    if (chosenDestination){
      planet = planetarySystem.randomPlanet();
    } else {
      planet = planetarySystem.planetWithName(
        promptAnswer('Name the planet you would like to visit'));
    }
    travelTo(planet);
  }

  // Displays travel message to user (if non existing planet was entered manually 
  // by user at input prompt then program displays 'Null' for planet name and description).
  void travelTo(Planet planet){
    print('Traveling to ${planet.name}.');
    print('Arrived at ${planet.name}. ${planet.description}');
  }

}

