import 'package:flutter/material.dart';

class GameEnd extends StatelessWidget {
  GameEnd({super.key, required this.tileCount, required this.score, required this.highScore, required this.newGame});
  int tileCount;
  int score;
  int highScore;
  Function () newGame;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 500,
        height: 500,
        child: Card(
          child: Column(
            children: [
              const Text("GAME OVER"),
              Text("Score: $score"),
              Text("Number of Tiles Tapped: $tileCount"),
              ElevatedButton(
                onPressed: ()
                {
                  newGame();
                }, 
                child: const Text("Return to Start"))

            ],
          ),
        )
      ),
    );
}}