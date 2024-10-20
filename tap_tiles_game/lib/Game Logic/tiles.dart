// The interactive tiles
import 'package:flutter/material.dart';
import 'dart:math';

// One tile
class OneTile extends StatelessWidget {
  OneTile({super.key, required this.state, required this.tilePressed, required this.index});
  bool state; // Determines if the button is "On" or "Off"
  int index;
  Function (bool, int) tilePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: state ? Colors.black : Colors.white,
      height: 10,
      width: 10,
      child: TextButton(
        onPressed: ()
        {
          tilePressed(state, index);
        }, 
        child: const Text("")),
    );
  }
}

// The Grid of Tiles
class Grid extends StatelessWidget {
  Grid({super.key, required this.pressed, required this.states});
  ListOfStates states;
  Function(bool, int) pressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 500,
        height: 500,
        child: GridView.count(
          crossAxisCount: 5,
          children: List.generate(25, (index) {return OneTile(
            state: states[index],
            index: index, 
            tilePressed: (bool state, int index)
            {
              pressed(state, index);
            }
            
            );
            }),
          ),
      ),
    );
  }
}

// ListOfStates
class ListOfStates
{
  // The List of States to be Used by GridOfTiles
  List<bool> states;

  // Default Constructor
  ListOfStates() : states = randomStates();

  // Generate Random List
  static List<bool> randomStates()
  {
    // Make temp list with 10 true values
    List<bool> temp = List.filled(10, true, growable: true);

    // Add 15 false values
    temp.addAll(List.filled(15, false));

    // Shuffle the list
    temp.shuffle(Random());

    return temp;
    
  }

  // Access Operator 
  bool operator [](int index)
  {
    return states[index];
  }

  // [] Write Operator
  void operator []= (int index, bool value)
  {
    states[index] = value;
  } 

  // Tile Pressed and is Good Input, Change the State
  void change(int index)
  {
    // Change the tile that was chosen
    states[index] = !states[index];

    // Randomly change another tile that is "Off" to on
    bool changed = true;
    final Random random = Random();
    while (changed == true)
    {
      // Get random number between 1 - 25
      int random_number = random.nextInt(25);

      // Check to see if that Tile is "Off", and if so turn it on
      // Also check to see that the same tile is not chosen
      if (states[random_number] == false && index != random_number)
      {
        states[random_number] = true;
        changed = false;
      }

    }
  }
}

