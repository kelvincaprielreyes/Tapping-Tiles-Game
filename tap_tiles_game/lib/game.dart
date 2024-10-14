// The main page of the game, with score and timer
import 'package:flutter/material.dart';
import "tiles.dart";

class Game extends StatefulWidget {
  Game({super.key});
  ListOfStates states = ListOfStates();

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score: $score"),
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.green[300],
      body: Grid(
        states: widget.states,
        pressed: (bool state, int index)
        {
            // Button was on, add points, and change state
            if (state)
            {
               setState(() {
                 score += 10;
                 widget.states.change(index);
               });
            }
            // Lose Points
            else
            {
               setState(() {
                 score -= 5;
               });
            }
        }
      )
    );
  }
}