import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rungame/game/skateboardera_girl.dart';
import 'package:rungame/screens/game_over_screen.dart';
import 'package:rungame/screens/menu_screen.dart';

void main() {
  final game = skateboarderGirl();
  runApp(GameWidget(
    game: game,
    initialActiveOverlays: const [MenuScreen.id],
    overlayBuilderMap: {
      'menu': (context, _) => MenuScreen(
            game: game,
          ),
      'gameOver': (context, _) => GameOverScreen(game: game),
    },
  ));
}
