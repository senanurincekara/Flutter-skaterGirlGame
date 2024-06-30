import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/src/text/renderers/text_renderer.dart';
import 'package:flutter/material.dart';
import 'package:rungame/components/background.dart';
import 'package:rungame/components/flower_group.dart';
import 'package:rungame/components/ground.dart';
import 'package:rungame/components/skaterGirl.dart';
import 'package:rungame/game/skater_girl_movement.dart';

class skateboarderGirl extends FlameGame
    with TapDetector, HasCollisionDetection {
  late SkaterGirl skatergirl;
  late TextComponent score;
  final double scrollSpeed = 100; // Ekranın yatay hareket hızı
  bool isHit = false;

  late FlowerGroup flowerGroup;

  @override
  Future<void> onLoad() async {
    flowerGroup = FlowerGroup();
    addAll([
      Background(),
      Ground(),
      skatergirl = SkaterGirl(),
      flowerGroup,
      score = buildScore()
    ]);
  }

  @override
  void onTap() {
    skatergirl.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Oyun ekranının yatay hareketi
    camera.moveBy(Vector2(scrollSpeed * dt, 0));
    score.text = 'Score: ${skatergirl.score}';
  }

  TextComponent buildScore() {
    return TextComponent(
        // text: 'Score: 0',
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 40, fontFamily: 'Game', fontWeight: FontWeight.bold),
        ));
  }

  void resetGame() {
    skatergirl.reset();
    skatergirl.current = SkaterGirlMovement.middle;
    flowerGroup.resetFlowers(); // FlowerGroup bileşenini sıfırla
  }
}
