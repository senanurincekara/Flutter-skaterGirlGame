import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rungame/game/assets.dart';
import 'package:rungame/game/skateboardera_girl.dart';

class GameOverScreen extends StatelessWidget {
  final skateboarderGirl game;

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black38,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Score: ${game.skatergirl.score}',
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontFamily: 'Game',
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(Assets.gameOver),
              const SizedBox(height: 1),
              ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 19, 0, 50)),
                child: const Text(
                  'Restart',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 241, 225, 246),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void onRestart() {
    game.skatergirl.reset();
    game.skatergirl.resetPosition();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
