import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rungame/game/assets.dart';
import 'package:rungame/game/skateboardera_girl.dart';

class MenuScreen extends StatelessWidget {
  final skateboarderGirl game;
  static const String id = 'menu';
  const MenuScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove('menu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(Assets.menu),
        ),
      ),
    );
  }
}
