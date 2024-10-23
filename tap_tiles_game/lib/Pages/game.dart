// The main page of the game, with score and timer
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import 'package:tap_tiles_game/Game%20Logic/end.dart';

import "../Game Logic/tiles.dart";
import "../Game Logic/start.dart";
import "../Game Logic/end.dart";
import "../Pages/login.dart";

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
  late int stored_highscore = 0; // High Score stored in Firestore
  late int highScore = 0; // Local highscore
  late final String userID;

  // Initialization Function 
  @override
  void initState()
  {
    super.initState();
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null)
    {
      userID = user.uid;
      initializeHighScore(userID);
    }
    // Else go back to login in
    else
    {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void initializeHighScore(userID) async
  {
    highScore = await getHighScore((userID));
    stored_highscore = highScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) 
          {
            return IconButton(
              onPressed: ()
              {
                Scaffold.of(context).openDrawer();
              }, 
              icon: const Icon(Icons.menu));
          }
        ),
        title: Text("Score: $score                                                                                                                                                   High Score: $highScore"),
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.green[300],
      drawer: Drawer(
        backgroundColor: Colors.green[300],
        child: Column(
          children: [
            const Text("Menu",
            style: TextStyle(
              color: Colors.black,
              fontSize: 80,
            ),),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () => SignOutButton(context),
              child: const Text("Sign Out")),
          ],
        )
        
      ),
      
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

                  // TEMP! GAME END CONDITION 
                  if (deduction == 50)
                  {
                     _checkHighScore();
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
  
  // Reset game state
  void _reset() async
  {
      
      score = 0;
      deduction = 5; 
      totalCount = 0; 
      deductionCount = 0; 
      removed = 0;
  }

  // Check to see if High Score needs to be updated
  void _checkHighScore() async
  {   
      if (stored_highscore < score)
      {
         await storeNewHighScore(score);
         stored_highscore = score;
         highScore = score;
      }
  }
}

// To do:
// added 3 strikes and out rule?
// add timer
// change location of tile logic to ListOfTiles object, or maybe not?
// make it so that as the game progresses the color of the On tiles start to shift to white
// Make it so that highScore when initstate of Game is gotten before the widget is drawn
// Maybe change two addtional tiles, so that they are kept on their toes?