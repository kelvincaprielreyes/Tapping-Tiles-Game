import 'package:flutter/material.dart';

// The Controller for the Game State
enum GAMESTATE {START, IN_PROGRESS, END}

// The Start widget

class GameStart extends StatelessWidget {
  GameStart({super.key, required this.start});
  Function () start;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 500,
        height: 500,
        child: IconButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
          ),
          onPressed: ()
          {
            start();
          }, 
          icon: const Icon(
            Icons.play_arrow,
            color: Colors.black,
            size: 500,)
        )
      ),
    );
  }
}