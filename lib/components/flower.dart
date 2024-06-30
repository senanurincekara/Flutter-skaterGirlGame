import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:rungame/game/assets.dart';
import 'package:rungame/game/configuration.dart';
import 'package:rungame/game/skateboardera_girl.dart';

class Flower extends SpriteComponent with HasGameRef<skateboarderGirl> {
  Flower({required this.height});

  @override
  final double height;

  @override
  Future<void> onLoad() async {
    final flower = await Flame.images.load(Assets.flower);
    size = Vector2(50, height);
    position.y = gameRef.size.y - size.y - Config.groundHeight;
    position.x = gameRef.size.x; // Ekranın sağ tarafından başlasın
    sprite = Sprite(flower);

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Çiçeğin yatay pozisyonunu oyun ekranı hareketine göre ayarla
    position.x -= gameRef.scrollSpeed * dt;

    // Çiçeği ekranın sağ tarafından yeniden eklemek için kontrol et
    if (position.x + size.x < 0) {
      position.x = gameRef.size.x;
    }
  }
}
