import 'dart:math';


// Model Class that generates a random fate using the random number generator 
class RandomFate {
  // Seeds random number generator
  Random random = Random();
  int counter = 0;
  String fate;
  var responses = ['Yes yes yes!', 'No way baby', 'Sure tell yourself that', 'Try again...', 'Nuh uh never', 'Let me think about it', 'Oh yeah~', 'Come back later'];

  String testFate(){
    counter = random.nextInt(8);
    return fate = responses[counter];
  }
}