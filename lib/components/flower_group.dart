import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:rungame/components/flower.dart';
import 'package:rungame/game/skateboardera_girl.dart';

class FlowerGroup extends PositionComponent with HasGameRef<skateboarderGirl> {
  FlowerGroup();

  @override
  Future<void> onLoad() async {
    resetFlowers();
    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void resetFlowers() {
    gameRef.isHit = false;
    removeAll(children);
    add(Flower(height: 50));
  }
}
