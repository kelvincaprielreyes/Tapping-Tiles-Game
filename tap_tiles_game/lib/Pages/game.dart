// The main page of the game, with score and timer
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tap_tiles_game/Game%20Logic/end.dart';

import "../Game Logic/tiles.dart";
import "../Game Logic/start.dart";
import "../Game Logic/end.dart";

class Game extends StatefulWidget {
  Game({super.key});
  ListOfStates states = ListOfStates();
  var game_state = GAMESTATE.START;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int score = 0;
  int deduction = 5; // Penalty for wrong tile starts at 5
  int totalCount = 0; // Total number of tiles that have been tapped
  int deductionCount = 0; // Tracking of number of tiles to be removed
  int removed = 0; // Number of tiles that have been removed
  //late int highScore = 0;
  //late String userID;

  // Add initialization function,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score: $score                                                                                                                                                                  High Score: 0"),
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.green[300],
      // Here is the game state decider?
      body: switch (widget.game_state)
      {
         GAMESTATE.IN_PROGRESS =>
            GameGrid(
               states: widget.states,
               pressed: (bool state, int index)
               {
                  // Button was on, add points, and change state
                  if (state)
                  {
                     setState(() {
                     score += 10;
                     totalCount++;

                     // Every 30 tiles, reduce the number of tiles that are valid by one
                     // Caps at five tiles on screen
                     if (deductionCount == 30 && removed < 5)
                     {
                        widget.states.reduce(index);
                        removed++;
                        deductionCount = 0;
                     }
                     // Else do a change action
                     else
                     {
                        widget.states.change(index);
                        deductionCount++;
                     }

                     });
                  }
                  // Lose Points
                  else
                  {
                     setState(() {
                        score -= deduction;
                 
                     // Increase penalty
                     deduction += 5;
                     });
                  }

                  // TEMP!
                  if (deduction == 50)
                  {
                     setState(() {
                       widget.game_state = GAMESTATE.END;
                     }); 
                  }
               }
               ),
         GAMESTATE.START =>
            GameStart(
               start: ()
               {
                  setState(() {
                    widget.states.randomStates();
                    widget.game_state = GAMESTATE.IN_PROGRESS;
                  });
               }),
         GAMESTATE.END =>
            GameEnd(
               tileCount: totalCount, 
               score: score, 
               highScore: 0, 
               newGame: ()
               {
                  setState(() {
                     _reset();
                    widget.game_state = GAMESTATE.START;
                  });
               })
      }
    );
  }

  void _reset()
  {
      score = 0;
      deduction = 5; 
      totalCount = 0; 
      deductionCount = 0; 
      removed = 0;
  }
}

// To do:
// added 3 strikes and out rule
// add timer
// change location of tile logic to ListOfTiles object, or maybe not?
// make it so that as the game progresses the color of the On tiles start to shift to white