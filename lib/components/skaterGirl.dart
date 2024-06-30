import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rungame/game/assets.dart';
import 'package:rungame/game/configuration.dart';
import 'package:rungame/game/skateboardera_girl.dart';
import 'package:rungame/game/skater_girl_movement.dart';

class SkaterGirl extends SpriteGroupComponent<SkaterGirlMovement>
    with HasGameRef<skateboarderGirl>, CollisionCallbacks {
  SkaterGirl();
  int score = 0;

  @override
  Future<void> onLoad() async {
    final skaterGirlCharacter = await gameRef.loadSprite(Assets.skatergirl);
    final skaterGirlCharacterUp = await gameRef.loadSprite(Assets.skatergirlUp);
    FlameAudio.audioCache
        .loadAll([Assets.flying, Assets.collision, Assets.point]);

    size = Vector2(120, 120);
    double bottomPadding = 190;
    position = Vector2(120, gameRef.size.y - size.y - bottomPadding);

    current = SkaterGirlMovement.middle;
    sprites = {
      SkaterGirlMovement.middle: skaterGirlCharacter,
      SkaterGirlMovement.up: skaterGirlCharacterUp,
    };

    add(RectangleHitbox());
  }

  void fly() {
    if (current != SkaterGirlMovement.up && !gameRef.isHit) {
      try {
        FlameAudio.play(Assets.flying);
        debugPrint('çaldı canım');
      } catch (e) {
        debugPrint('Error playing audio: $e');
      }
      add(
        MoveByEffect(
          Vector2(0, Config.gravity),
          EffectController(duration: 0.5, curve: Curves.decelerate),
          onComplete: () {
            if (current != SkaterGirlMovement.up && !gameRef.isHit) {
              current = SkaterGirlMovement.up;
              debugPrint('if up tan sonra ki ');
              Future.delayed(Duration(milliseconds: 1500), () {
                if (!gameRef.isHit) {
                  debugPrint("if game is hit -->  ${game.isHit}");
                  resetPosition();
                  current = SkaterGirlMovement.middle;
                  gameRef.skatergirl.score++;
                  try {
                    FlameAudio.play(Assets.point);
                    debugPrint('çaldı point');
                  } catch (e) {
                    debugPrint('Error playing audio: $e');
                  }
                  debugPrint("Score fly file: ${gameRef.skatergirl.score}");
                } else {
                  resetPosition();
                  return;
                }
              });
            }
          },
        ),
      );
    } else {
      debugPrint('Collision detected while flying, exiting fly function');
      current = SkaterGirlMovement.middle;
      return;
    }
  }

  void resetPosition() {
    debugPrint('reset position ');
    size = Vector2(120, 120);
    double bottomPadding = 190;
    position = Vector2(
      120,
      gameRef.size.y - size.y - bottomPadding,
    );
    current = SkaterGirlMovement.middle;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    debugPrint('Collision detected ');

    gameOver();
  }

  void gameOver() {
    try {
      FlameAudio.play(Assets.collision);
      debugPrint('çaldı game over');
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }

    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
    game.isHit = true;
    resetPosition();

    debugPrint("game is hit -->  ${game.isHit}");
  }

  void reset() {
    gameRef.flowerGroup.resetFlowers();
    current = SkaterGirlMovement.middle;
    score = 0;
  }
}
