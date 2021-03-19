A command-line pure dart program, that expects the path to the JSON file as a command-line argument. The program prints the output and supports the interaction shown in the screen specification.

Flow of program:
1. Prints a greeting including the name of the planetary system and the number of planets in the system.
2. Prompts user to enter their name.
3. Echoes back user's name.
4. Prompts user to make a choice about traveling to a random planet or not.
    * Re-prompts user repeatedly until they enter Y or N to stop run of program.
    * Selects a random planet and prints its name and description when the user chooses to travel to a random planet.
    * Prompts  user to enter the name of a planet to travel to, if they chose not to travel to a random planet.
      * Display the name and description of the planet that the user specified.
      * Handle the case where the user enters the name of a planet that is not in the data file.
5. Terminates execution at the end of the above interaction.
