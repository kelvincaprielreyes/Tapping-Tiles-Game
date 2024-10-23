import 'package:flutter/material.dart';

class GameEnd extends StatelessWidget {
  GameEnd({super.key, required this.tileCount, required this.score, required this.newGame});
  int tileCount;
  int score;
  Function () newGame;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 500,
        height: 500,
        color: const Color.fromARGB(255, 73, 163, 68),
        child: Card(
          shadowColor: Colors.transparent,
          color: const Color.fromARGB(255, 73, 163, 68),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("GAME OVER",
                style: TextStyle(
                  fontSize: 75,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("Score: $score", 
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("Number of Tiles Tapped: $tileCount",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(5, 150, 5, 0),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 107, 85, 208),
                    ),
                    onPressed: ()
                    {
                      newGame();
                    }, 
                    child: const Text("Play Again?",
                      style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                ),)),
                ),
              )

            ],
          ),
        )
      ),
    );
}}